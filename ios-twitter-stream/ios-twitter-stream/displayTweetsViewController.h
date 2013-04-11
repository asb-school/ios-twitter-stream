//
//  displayTweetsViewController.h
//  ios-twitter-stream
//
//  Created by Andrew Breja on 4/11/13.
//  Copyright (c) 2013 Andrew Breja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketController.h"

@interface displayTweetsViewController : UIViewController
{

}

@property (nonatomic) NSArray *tableData;
@property (nonatomic) SocketController *socketController;

@end
