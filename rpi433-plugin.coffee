module.exports = (env) ->
  Promise = env.require 'bluebird'
  assert = env.require 'cassert'
  commons = require('pimatic-plugin-commons')(env)
  rpi433 = require('rpi-433')
  deviceConfigTemplates = [
    {
      "name": "rpi433 switch"
      "class": "Rpi433Switch"
    }
  ]

  class Rpi433Plugin extends env.plugins.Plugin
    init: (app, @framework, @config) =>
      @debug = @config.debug || false
      @base = commons.base @, 'Plugin'
      deviceConfigDef = require("./device-config-schema")
      @emitter = @config.emitter
      if(@debug)
        rfSniffer = rpi433.sniffer({
          pin: @config.receiver,
          debounceDelay: 500
          })
        rfSniffer.on 'data', (data) =>
          console.log('Code received: '+data.code+' pulse length : '+data.pulseLength)


      for device in deviceConfigTemplates
        className = device.class

        # convert camel-case classname to kebap-case filename
        filename = className.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()

        classType = require('./devices/' + filename)(env)

        @base.debug "Registering device class #{className}"
        @framework.deviceManager.registerDeviceClass(className, {
          configDef: deviceConfigDef[className],
          createCallback: @_callbackHandler(className, classType)
        })

    _callbackHandler: (className, classType) ->
      # this closure is required to keep the className and classType context as part of the iteration
      return (config, lastState) =>
        return new classType(config, @, lastState)

  return new Rpi433Plugin
