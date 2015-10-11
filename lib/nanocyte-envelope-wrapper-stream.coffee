{Transform} = require 'stream'
fs = require 'fs'
class NanocyteEnvelopeStream extends Transform
  constructor: (options) ->
    super objectMode: true

    {@data={}, @config={}} = options

  _transform:(message, enc, next) =>
    @push data: @data, config: @config, message: message
    next()

module.exports = NanocyteEnvelopeStream
