//
//  SocketController.m
//  chat
//
//  Created by Andrew Breja on 4/8/13.
//
//

#import "SocketController.h"

@implementation SocketController


// --------------------------------------------------------------
// SETUP CONNECTION

- (void)setupConnection
{
    // Setup Socket IO
    socketIOHandler = [[SocketIO alloc] initWithDelegate:self];
    
    // Create connection to server
    [socketIOHandler connectToHost:@"localhost" onPort:5050];
}


- (void)setUpdateCallbackFunction:(id)object withSelect:(SEL)callback
{
    objectRef = object;
    callbackRef = callback;
}


// --------------------------------------------------------------
// SEND MESSAGE

- (void)sendMessageOnChannel:(NSString *)channel andMessage:(NSString *)message
{
    // Setup message object with a dictionary
    NSMutableDictionary *messageObject = [NSMutableDictionary dictionary];
    
    // Add data to message object
    [messageObject setObject:message forKey:@"msg"];
    
    // Send the data to the server
    [socketIOHandler sendEvent:channel withData:messageObject];
}


// --------------------------------------------------------------
// ON RECEIVE EVENT

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    // Debug logging
    NSLog(@"didReceiveEvent()");
    NSLog(@"Data: %@", packet.data);
    
    // Check if we have the right event
//    if (packet.name == 'main')
//    {
//        // do stuff
//    }
    
    NSError *jsonParseError;
    
    // Convert packet data string into NSData
    NSData *jsonData = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
    
    // Convert JSON into Foundation object
    NSDictionary *packetData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonParseError];
    
    // Get the message
    for (NSDictionary *key in [packetData objectForKey:@"args"])
    {
        NSLog(@"message: %@", [key objectForKey:@"msg"]);
        
        [objectRef performSelectorOnMainThread:callbackRef withObject:[key objectForKey:@"msg"] waitUntilDone:NO];
    }
    
    // SocketIO Callback
//    SocketIOCallback cb = ^(id argsData)
//    {
//        NSDictionary *response = argsData;
//        
//        // do something with response
//        NSLog(@"ack arrived: %@", response);
//    };
    
//    [socketIOHandler sendMessage:@"hello back!" withAcknowledge:cb];
}


// --------------------------------------------------------------
// ON FAILURE TO CONNECT

- (void) socketIO:(SocketIO *)socket failedToConnectWithError:(NSError *)error
{
    NSLog(@"failedToConnectWithError() %@", error);
}



@end
