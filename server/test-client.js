/*
**
**	iOS TWITTER STREAM
**	Andrew Breja
**
**	Test Client
**	Start with search term and display tweets
**
*/


// --------------------------------------------------------------
// IMPORTS

var commander = require('commander');
var io = require('socket.io-client');


// --------------------------------------------------------------
// SETUP

var socket = io.connect('localhost', { port: 5060 });


// --------------------------------------------------------------
// COMMAND LINE ARGUMENTS

commander.version('0.1');
commander.usage('[option] value');
commander.option('-t --terms [terms]', 'Twitter search terms');
commander.parse(process.argv);

// For each search term
for (term in commander.terms)
{

}

socket.on('connect', function ()
{
	// do stuff
});

socket.emit()