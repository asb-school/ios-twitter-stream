/*
**
**	iOS TWITTER STREAM
**	Andrew Breja
**
**	Relay Server
**	Consumes Twitter Streams based on search terms and
**	relays to Socket.IO clients
**
*/


// --------------------------------------------------------------
// IMPORTS

var io = require('socket.io').listen(5060);
var twitter = require('ntwitter');
var EventEmitter = require('events').EventEmitter;
var server = new EventEmitter();


// --------------------------------------------------------------
// CONFIG

var twitterApiHandler = new twitter(
{
	consumer_key: 'WWUQperuJGELWBdkK68KOA',
	consumer_secret: 'Hjv7s3ACIvt5xBRPwfpBJ4V3dmfhP8U5GshOkdeKk',
	access_token_key: '1342471338-GgAjVNPey3bUtjxkvDxt9CsV3Qt3Oq7oN2pT8Wa',
	access_token_secret: 'MwpoTRR7KElya12VcgZTXV5JtZqfv3KhQ3ipOONkk'
});



// --------------------------------------------------------------
// START SOCKET.IO

// On socket.io connection
io.sockets.on('connection', function (socket)
{
	// MOTD
	socket.emit('mgmt', { msg: 'Connect ACK' });

	// On request message, handle request
	socket.on('req', function (data)
	{
		searchTwitterStream(socket, data.msg);
	});

	socket.on('disconnect', function (socket)
	{
		server.emit('client-disconnect');
	});
});


// --------------------------------------------------------------
// SEARCH TWITTER STREAM

function searchTwitterStream(socket, searchTerms)
{
	// Twitter API Search Stream
	twitterApiHandler.stream('statuses/filter',
	{
		// Filter with given search terms
		track: searchTerms
	},

	function(stream)
	{
		// When we get data, send it to the client
	    stream.on('data', function(tweet) 
	    {
			// Send tweet back to client
			socket.emit('tweets', { msg: tweet.text });
	    });

	    // On client disconnect, destroy the stream
	    server.on('client-disconnect', function()
	    {
	    	stream.destroy;
	    });
	});
}