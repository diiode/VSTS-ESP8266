local module = {}

module.TIMER_WIFI = 1
module.TIMER_GET_BUILD = 2

-- Pins
module.LED_STRIP_DATA_PIN = 2
module.LED_STRIP_CLOCK_PIN = 1

-- Led config
module.KIOSK_LED = 1
module.ADMIN_LED = 2
module.WEB_APP_LED = 3
module.API_LED = 4
module.FRAMEWORK_LED = 5
module.INTEGRATION_LED = 6
module.CORDOVA_WEB_LED = 7

-- Build definition IDs
module.KIOSK_DEFINITION_ID = 100
module.ADMIN_DEFINITION_ID = 46
module.WEB_APP_DEFINITION_ID = 104
module.API_DEFINITION_ID = 83
module.FRAMEWORK_DEFINITION_ID = 99
module.INTEGRATION_DEFINITION_ID = 102
module.CORDOVA_WEB_DEFINITION_ID = 113

module.MAX_LEDS = 10

return module
