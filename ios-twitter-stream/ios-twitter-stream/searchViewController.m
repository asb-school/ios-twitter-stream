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


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableData removeObjectAtIndex:indexPath.row];

        [searchTermsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // If we are going to the display tweets view
    if([segue.identifier isEqualToString:@"searchToDisplaySeg"])
    {
        displayTweetsViewController *controller = (displayTweetsViewController *)segue.destinationViewController;

        // Copy table data to the display tweets view controller
        controller.tableData = tableData;
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
    
    // Reload table data
    [searchTermsTable reloadData];
    
    // Create an index path
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[tableData count]-1 inSection:0];

    // Insert row in table view
    [searchTermsTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation: UITableViewRowAnimationFade];

    // Clear text field
    searchTermField.text = @"";
    
    // Scroll to bottom if we have a lot of items
    if (tableData.count > 1)
    {
        [searchTermsTable scrollToRowAtIndexPath: [NSIndexPath indexPathForRow:[tableData count]-1 inSection:0] atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
}

- (IBAction)displayTweetsView:(id)sender
{
}
@end
