#!coffee
JSONParseStream = require 'simple-json-parse-stream'
JSONStringifyStream = require 'simple-json-stringify-stream'
NanocyteComponentEqual = require 'nanocyte-component-equal'
process.stdin
  .pipe new JSONParseStream
  .pipe new NanocyteComponentEqual
  .pipe new JSONStringifyStream
  .pipe process.stdout
