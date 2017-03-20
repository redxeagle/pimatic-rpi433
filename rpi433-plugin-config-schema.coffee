module.exports = {
  title: "Options for pimatic rpi433"
  type: "object"
  properties:
    debug:
      description: "debug output on or off"
      type: "boolean"
      default: false
    emitter:
      description: "pin for the emitter"
      type: "integer"
      default: 22
    receiver:
      description: "pint for the receiver - sniffer"
      type: "integer"
      default: 22
}
