local module = {}


function module.start()  
    a = 20
    b = 255
    g = 255
    r = 255

    leds_abgr = string.char(a, 0, 0, r, a, 0, g, 0, a, b, 0, 0) 
    print("Setting ledstrip: " .. leds_abgr)
    -- data, clock, string
    apa102.write(2, 1, leds_abgr)
end

return module
