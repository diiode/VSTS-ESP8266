# Vsts Api ESP8266 Lua #

IoT application to show the [VSTS](https://www.visualstudio.com/team-services/) Build statuses of your projects on a ledstrip.

## How To ##
Setup:

 1. Add credentials for WiFi and VSTS API key.
 2. Add the build definition IDs to the config.

### Credentials ###
Create a file *credentials.lua*

Add following lines (replace *xxx*):

```
module.SSID = "xxx"
module.PASSWORD = "xxx"

module.VSTS_PERSONAL_ACCESS_TOKEN = "xxx"
module.URL = "xxx"
```

Url format example: `https://fabrikam-fiber-inc.visualstudio.com/DefaultCollection/Fabrikam-Fiber-Git/_apis/build/builds?definitions=`

### Config ###
Change the *led config* and *build definition ids* in the file: *config.lua* to your project values.

## Hardware ##

 - Adafruit HUZZAH Feather ESP8266, [link](https://www.adafruit.com/products/2821)
 - APA102 ledstrip

## Firmware ##

Build new firmware (from dev branch): [doc](https://nodemcu.readthedocs.io/en/master/en/build/)

Flash new firmware with: [nodemcu flasher](https://github.com/nodemcu/nodemcu-flasher)

Upload lua code with: [ESPlorer](https://github.com/4refr0nt/ESPlorer) 

## Notes ##
For sending requests to https we need firmware with HttpS support. Build a firmware with SSL enabled.

Done with docker option:
 - enable SSL_CLIENT in *user_config.h*
 - enable other lua modules in: user_modules.h

## Docs & links ##

 - [VSTS API](https://www.visualstudio.com/en-us/docs/integrate/api/overview)
 - [Nodemcu docs](https://nodemcu.readthedocs.io/en/master/)