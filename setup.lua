local module = {}

local function wifi_wait_ip()  
  if wifi.sta.getip()== nil then
    print("IP unavailable, Waiting...")
  else
    tmr.stop(1)
    print("\n====================================")
    print("ESP8266 mode is: " .. wifi.getmode())
    print("MAC address is: " .. wifi.ap.getmac())
    print("IP is "..wifi.sta.getip())
    print("====================================")
    app.start()
  end
end

local function wifi_start(list_aps)
    print("setup:wifi_start")
    if list_aps then
        for key, value in pairs(list_aps) do
            print(key .. " - " .. value)
            if key == credentials.SSID then
                wifi.setmode(wifi.STATION)
                wifi.sta.config(key, credentials.PASSWORD)
                wifi.sta.connect()
                --config.SSID = nil  -- can save memory
                tmr.alarm(config.TIMER_WIFI, 2500, 1, wifi_wait_ip)
            end
        end
    else
        print("Error getting AP list")
    end
end

function module.start() 
    print("Clearing led strip")
    led_strip.clear()
    print("Credentials SSID: " .. credentials.SSID)
    print("Credentials PASSWORD: " .. credentials.PASSWORD)
    print("Configuring Wifi ...")
    wifi.setmode(wifi.STATION)
    print("Configured sta as station")
    wifi.sta.getap(wifi_start)
end

return module
