local module = {} 
m = nil

local build_result_array = { }

local auth_header = "Authorization: Basic " .. credentials.VSTS_PERSONAL_ACCESS_TOKEN .. "\r\n"
local full_header = "Accept: */*\r\n"..
                auth_header ..
                "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua;)"..
                "\r\n\r\n"

local function parse_http_response(data)
    local t = {}
    t.status = string.match(data,"\"status\":\"(%w+)\"")
    t.result = string.match(data, "\"result\":\"(%w+)\"")
    return t
end

local function get_url(definition_id)
    return credentials.URL .. definition_id .. "&$top=1&api-version=2.0"
end

local function get_http_single(definition_id)
    local url = get_url(definition_id)

    http.get(url, full_header, function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        else
            if(code == 200) then
                parsed_response = parse_http_response(data)
                build_result_array = { }
                build_result_array[1] = parsed_response
                led_strip.set_leds(build_result_array)
            else
                print("Server returned HTTP code: " .. code)
            end
        end
    end)
end

local function get_http(definition_id, led_id, callback)
    local url = get_url(definition_id)

    http.get(url, full_header, function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        else
            if(code == 200) then
                parsed_response = parse_http_response(data)
                build_result_array[led_id] = parsed_response
            else
                print("Server returned HTTP code: " .. code)
            end
        end
        node.task.post(callback)
    end)
end

local function finish()
    led_strip.set_leds(build_result_array)
    -- rtctime.dsleep(10*1000000)
end

local function get_cordova_web()
    get_http(config.CORDOVA_WEB_DEFINITION_ID, config.CORDOVA_WEB_LED, finish)
end

local function get_integration()
    get_http(config.INTEGRATION_DEFINITION_ID, config.INTEGRATION_LED, get_cordova_web)
end

local function get_framework()
    get_http(config.FRAMEWORK_DEFINITION_ID, config.FRAMEWORK_LED, get_integration)
end

local function get_api()
    get_http(config.API_DEFINITION_ID, config.API_LED, get_framework)
end

local function get_web_app()
    get_http(config.WEB_APP_DEFINITION_ID, config.WEB_APP_LED, get_api)
end

local function get_admin()
    get_http(config.ADMIN_DEFINITION_ID, config.ADMIN_LED, get_web_app)
end

local function get_kiosk()
    get_http(config.KIOSK_DEFINITION_ID, config.KIOSK_LED, get_admin)
end


function module.start()
    print("Starting app\n")
    get_kiosk()
    tmr.alarm(config.TIMER_GET_BUILD, 5 * 60 * 1000, tmr.ALARM_AUTO, get_kiosk)
end

return module
