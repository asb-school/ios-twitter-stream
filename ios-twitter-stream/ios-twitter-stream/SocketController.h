//
//  SocketController.h
//  chat
//
//  Created by Andrew Breja on 4/8/13.
//
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"
#import "SocketIOPacket.h"

@interface SocketController : NSObject <SocketIODelegate>
{
    // PROPERTIES
    
    SocketIO *socketIOHandler;
    SEL callbackRef;
    id objectRef;
}


// FUNCTIONS

- (void)setupConnection;
- (void)sendMessageOnChannel:(NSString*)channel andMessage:(NSString*)message;
- (void)setUpdateCallbackFunction:(id)object withSelect:(SEL)callback;

@end