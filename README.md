rpi-433 plugin
=======================

## Prerequisites
**important notice**

Tested it with a raspberry pi 3 and raspbian. Had trouble to get the pimatic-homeduino plugin to install.
Always failed with npm package serialport installation.

But with the npm libary rpi433 it was really easy to read out 433 mhz sensor.

## What can this plugin do?
- Control Devices
    - Power switch


## Plugin settings in Pimatic

```
    {
    "plugin": "rpi433",
    "emitter": 21,
    "receiver": 22,
    "debug": true
    },
```
With debug mode to true and pimatic in normal console run you can read out the remote. Codes will be output to console currently.

## Device settings in Pimatic

### switch device

```
  {
    "id": "TVButton",
    "name": "TV Power",
    "class": "Rpi433Switch",
    "on": "87347",
    "off": "87356"
  }
```


## To-do
- Currently only the configured codes can be send via emitter sensor. Plan for the future is that the receiver also is supported and switch on/off devices in case the origin remote is used.
