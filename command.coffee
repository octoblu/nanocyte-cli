commander = require 'commander'
JSONParseStream = require 'simple-json-parse-stream'
JSONStringifyStream = require 'simple-json-stringify-stream'
NanocyteEnvelopeWrapperStream = require './lib/nanocyte-envelope-wrapper-stream'

commander.version('1.0.0')
  .arguments '<nanocyte>'
  .option '-d, --data-file <data>', 'file containing the data for the nanocyte node'
  .option '-c, --config-file <config>', 'file containing the config for the nanocyte node'
  .parse process.argv

return commander.outputHelp() unless commander.args[0]?
data = {}
config = {}
data = require(commander.dataFile) if commander.dataFile?
config = require(commander.configFile) if commander.configFile?

nanocyteClass = require commander.args[0]

process.stdin
  .pipe new JSONParseStream
  .pipe new NanocyteEnvelopeWrapperStream config: config, data: data
  .pipe new nanocyteClass
  .pipe new JSONStringifyStream
  .pipe process.stdout
