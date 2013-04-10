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

var io = require('socket.io');
var twitter = require('ntwitter');


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

// Start listening on port 5060
io.listen(5060);

// On socket.io connection
io.sockets.on('connection', function (socket)
{
	// MOTD
	socket.emit('mgmt', { msg: 'Connect ACK' });

	// On request message, handle request
	socket.on('req', function (data)
	{
		handleRequest(socket, data);			
	});
});


// --------------------------------------------------------------
// HANDLE REQUEST

function handleRequest(socket, data)
{
	// Search terms collection
	var searchTerms = [];

	// Add data to search terms
	searchTerms.push(data.msg);

	// Search twitter stream with the given search terms
	searchTwitterStream(socket, searchTerms);
}


// --------------------------------------------------------------
// SEARCH TWITTER STREAM

function searchTwitterStream(socket, searchTerms)
{
	twitterApiHandler.stream('statuses/filter',
	{ 
		track: searchTerms
	},

	function(stream)
	{
	    stream.on('data', function(tweet) 
	    {
			console.log(tweet.text);

			// Send tweet back to client
			socket.emit('tweets', { msg: tweet.text });
	    });
	});
}