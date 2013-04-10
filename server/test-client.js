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

// Split values by comman
function terms(value) 
{
	return value.split(',');
}

commander.version('0.1');
commander.usage('[option] value');
commander.option('-t --terms <terms>', 'Twitter search terms separated by commas', terms);
commander.parse(process.argv);


// --------------------------------------------------------------
// ON CONNECTION

socket.on('connect', function ()
{
	// Send a request to search for given terms
	socket.emit('req', { commander.terms });
});