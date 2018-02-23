
module.exports = (env) ->
  Promise = env.require 'bluebird'
  _ = env.require 'lodash'
  commons = require('pimatic-plugin-commons')(env)
  rpi433 = require('rpi-433')

  class Rpi433Switch extends env.devices.SwitchActuator
    constructor: (@config, @plugin, lastState) ->
      @_base = commons.base @, @config.class
      @debug = @plugin.debug || false
      @pulseLength = @config.pulseLength
      
      @rfemitter = rpi433.emitter({
          pin: @plugin.emitter,
          pulseLength: @pulseLength
        })

      @id = @config.id
      @name = @config.name
      @on_code = @config.on
      @off_code = @config.off
      @value_id = null
      @responseHandler = @_createResponseHandler()
      @_state = lastState?.state?.value or false
      super()

    _createResponseHandler: () =>
      return (response) =>
        @_setState false

    changeStateTo: (newState) ->
      return new Promise (resolve, reject) =>
        if(newState)
          @rfemitter.sendCode @on_code, (error, stdout)  =>
            if(!error)
              console.log(stdout)
        else
          @rfemitter.sendCode @off_code, (error,stdout) =>
            if(!error)
              console.log(stdout)
        @_setState newState
        resolve()

    getState: () ->
      return Promise.resolve @_state
