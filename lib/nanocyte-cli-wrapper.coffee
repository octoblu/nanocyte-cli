JSONParseStream = require 'simple-json-parse-stream'
JSONStringifyStream = require 'simple-json-stringify-stream'
NanocyteEnvelopeWrapperStream = require './nanocyte-envelope-wrapper-stream'
NanocyteComponentEqual = require 'nanocyte-component-equal'
config =
  left: 5,
  right: 5
  
data = {}

process.stdin
  .pipe new JSONParseStream
  .pipe new NanocyteEnvelopeWrapperStream config: config, data: data
  .pipe new NanocyteComponentEqual
  .pipe new JSONStringifyStream
  .pipe process.stdout
