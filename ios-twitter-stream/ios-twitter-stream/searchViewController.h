//
//  searchViewController.h
//  ios-twitter-stream
//
//  Created by Andrew Breja on 4/11/13.
//  Copyright (c) 2013 Andrew Breja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "displayTweetsViewController.h"

@interface searchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITextField *searchTermField;
    IBOutlet UITableView *searchTermsTable;
    
    NSMutableArray *tableData;
}

- (IBAction)addSearchTerm:(id)sender;

@end
