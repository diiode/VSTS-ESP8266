local module = {} 

local alpha = 20
local max_leds = 10

local colorEnum = {
    off = 0,
    red = 1,
    blue = 2,
    green = 3,
    cyan = 4,
    yellow = 5,
    orange = 6
}

-- Truth table for color parsing
--
-- Status     | Result             | Result Color | Extra
-- -----------------------------------------------------
-- inProgress | x                  | blue         |
-- completed  | succeeded          | green        |      
-- completed  | partiallySucceeded | orange       |
-- completed  | failed             | red          |      
-- completed  | canceled           | yellow       |
-- cancelling | x                  | yellow       |
-- postponed  | x                  | cyan         |
-- notStarted | x                  | cyan         |
--            |                    |              |
-- http error | x                  | off          |
--
-- Build statuses, see: https://www.visualstudio.com/en-us/docs/integrate/api/build/builds
local function get_color(build_result)
    if (build_result.status == build_results.status.inProgress) then
        return colorEnum.blue
    end
    if (build_result.status == build_results.status.cancelling) then
        return colorEnum.yellow
    end
    if (build_result.status == build_results.status.postponed or build_result.status == build_results.status.notStarted) then
        return colorEnum.cyan
    end
    if (build_result.status == build_results.status.completed) then
        if (build_result.result == build_results.result.succeeded) then
            return colorEnum.green
        end
        if (build_result.result == build_results.result.partiallySucceeded) then
            return colorEnum.orange
        end
        if (build_result.result == build_results.result.failed) then
            return colorEnum.red
        end
        if (build_result.result == build_results.result.canceled) then
            return colorEnum.yellow
        end
    end
end

local function get_colors(build_result_array)
    color_array = {}
    for i = 1, config.MAX_LEDS do
        color = colorEnum.off
        if build_result_array[i] ~= nil then
            color = get_color(build_result_array[i])
        end
        color_array[i] = color
    end
    return color_array
end

local function get_color_string(color)
    if color == colorEnum.off then
        return '_'
    end
    if color == colorEnum.red then 
        return 'R'
    end
    if color == colorEnum.green then 
        return 'G'
    end
    if color == colorEnum.blue then 
        return 'B'
    end
    if color == colorEnum.cyan then 
        return 'C'
    end
    if color == colorEnum.yellow then 
        return 'Y'
    end
    if color == colorEnum.orange then 
        return 'O'
    end
end

-- print version
local function write_string(color_array)
    local led_strip_string = ""
    for i=1, config.MAX_LEDS do
        local color_string = get_color_string(color_array[i])
        led_strip_string = led_strip_string .. "[" .. color_string .. "] "
    end
    print(led_strip_string)
end

local function get_color_apa(color)
    if color == colorEnum.off then
        return string.char(0, 0, 0, 0)
    end
    if color == colorEnum.red then 
        return string.char(alpha, 0, 0, 255)
    end
    if color == colorEnum.green then 
        return string.char(alpha, 0, 255, 0)
    end
    if color == colorEnum.blue then 
        return string.char(alpha, 255, 0, 0)
    end
    if color == colorEnum.cyan then 
        return string.char(alpha, 255, 255, 0)
    end
    if color == colorEnum.yellow then 
        return string.char(alpha, 0, 255, 255)
    end
    if color == colorEnum.orange then 
        return string.char(alpha, 0, 127, 255)
    end
end

local function write_apa(color_array)
    local led_strip_string_apa = ""
    for i=1, config.MAX_LEDS do
        local color_string_apa = get_color_apa(color_array[i])
        led_strip_string_apa = led_strip_string_apa .. color_string_apa
    end
    apa102.write(config.LED_STRIP_DATA_PIN, config.LED_STRIP_CLOCK_PIN, led_strip_string_apa)
end

function module.set_leds(build_result_array)
    color_array = get_colors(build_result_array)
    write_string(color_array)
    write_apa(color_array)
end

function module.clear()
    local led_strip_string_apa = ""
    for i=1, config.MAX_LEDS do
        led_strip_string_apa = led_strip_string_apa .. string.char(0, 0, 0, 0)
    end
    apa102.write(config.LED_STRIP_DATA_PIN, config.LED_STRIP_CLOCK_PIN, led_strip_string_apa)
end

return module
