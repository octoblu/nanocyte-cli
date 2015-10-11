commander = require 'commander'
JSONParseStream = require 'simple-json-parse-stream'
JSONStringifyStream = require 'simple-json-stringify-stream'
NanocyteEnvelopeWrapperStream = require './lib/nanocyte-envelope-wrapper-stream'
path = require 'path'
commander.version('1.0.0')
  .arguments '<nanocyte>'
  .option '-d, --data-file <data>', 'file containing the data for the nanocyte node'
  .option '-c, --config-file <config>', 'file containing the config for the nanocyte node'
  .parse process.argv

return commander.outputHelp() unless commander.args[0]?
data = {}
config = {}
if commander.dataFile?
  dataPath = path.join process.cwd(), commander.dataFile
  data = require dataPath

if commander.configFile?
  configPath = path.join process.cwd(), commander.configFile
  config = require configPath


nanocytePath = path.join process.cwd(), commander.args[0]
nanocyteClass = require nanocytePath

process.stdin
  .pipe new JSONParseStream
  .pipe new NanocyteEnvelopeWrapperStream config: config, data: data
  .pipe new nanocyteClass
  .pipe new JSONStringifyStream
  .pipe process.stdout
