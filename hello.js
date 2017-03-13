#! /usr/bin/env node
const argv = process.argv[2];
const exec = require('child_process').exec;

const child = exec('echo hello ' + argv, function(err, stdout, stderr){
	if (err) throw err;
	console.log(stdout);
});

exec('npm init -y');
