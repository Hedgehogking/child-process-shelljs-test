#! /usr/bin/env node 
const argv = process.argv[2];
const shell = require('shelljs');

shell.exec('echo hello world:' + argv);
