//
//  searchViewController.m
//  ios-twitter-stream
//
//  Created by Andrew Breja on 4/11/13.
//  Copyright (c) 2013 Andrew Breja. All rights reserved.
//

#import "searchViewController.h"

@interface searchViewController ()

@end

@implementation searchViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
//        SimpleEditableListAppDelegate *controller = (SimpleEditableListAppDelegate *)[[UIApplication sharedApplication] delegate];
        [tableData removeObjectAtIndex:indexPath.row];
//        [tableData removeObjectFromListAtIndex:indexPath.row];
        [searchTermsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Init table array
    tableData = [NSMutableArray new];
    
    [searchTermsTable setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSearchTerm:(id)sender
{
    // Add another item to the table
    [tableData addObject:searchTermField.text];
    
    // Reload table view
    [searchTermsTable reloadData];
    
    // Scroll to bottom if we have a lot of items
    if (tableData.count > 4)
    {
        [searchTermsTable scrollToRowAtIndexPath: [NSIndexPath indexPathForRow:[tableData count]-1 inSection:0] atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
}
@end
