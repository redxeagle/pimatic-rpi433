module.exports = {
  title: "pimatic-rpi433 device config schemas"
  Rpi433Switch: {
    title: "rpi433switch"
    type: "object"
    properties:
      on:
        description: "The on code"
        type: "string"
        default: "1234"
      off:
        description: "The off code"
        type: "string"
        default: "4321"
      pulseLength:
        description: "The pulse Length"
        type: "string"
        default: "178"
  }
}
