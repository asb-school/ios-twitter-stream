//
//  ViewController.m
//  ios-twitter-stream
//
//  Created by Andrew Breja on 4/10/13.
//  Copyright (c) 2013 Andrew Breja. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [socketController setupConnection];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitSearchTerms:(id)sender
{
    // Get search terms from input field
//    NSString *searchTerms = searchTermsInputField.text;
    
    // Convert to JSON
    
    // Send message via socket controller
//    [socketController sendMessageOnChannel:@"req" andMessage:searchTerms];
}

@end
