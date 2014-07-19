//
//  TDToDoListTableViewController.m
//  ToDo
//
//  Created by admin on 15/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "TDToDoListTableViewController.h"
#import "TDCoredataManager.h"

@interface TDToDoListTableViewController ()

@property(nonatomic, strong) NSArray *list;

@end

@implementation TDToDoListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dateFormatter = [[NSDateFormatter alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSPredicate *predicate = nil;
    BOOL ascending;
    if(self.view.tag == 0) {
        predicate = [NSPredicate predicateWithFormat:@"time < %@ ", [NSDate date]];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"time > %@ ", [NSDate date]];
        ascending = YES;
    }
    _list = [TDCoredataManager getAllExpenses:predicate];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:ascending];
    NSArray *descriptors = [NSArray arrayWithObject: descriptor];
    _list =[ _list sortedArrayUsingDescriptors:descriptors];
    
    if (sections == 0) {
        sections = 1;
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        [self.tableView reloadData];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.view.tag == 0)
        return @"History";
    else
        return @"Upcoming";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"ToDoListLeftCell";
    if (indexPath.row%2 == 0) {
        cellId = @"ToDoListRightCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    // Configure the cell...
    [cell viewWithTag:100].layer.cornerRadius = [[self.view viewWithTag:100] bounds].size.width/2;
    
    NSManagedObject *data = [_list objectAtIndex:indexPath.row];
    ((UILabel *)[cell viewWithTag:1]).text = [data valueForKey:@"title"];
    ((UILabel *)[cell viewWithTag:2]).text = [data valueForKey:@"notes"];
    [dateFormatter setDateFormat:@"HH:mm"];
    ((UILabel *)[cell viewWithTag:3]).text = [dateFormatter stringFromDate:[data valueForKey:@"time"]];
    [dateFormatter setDateFormat:@"a"];//Wed, Dec 14 2011 1:50 PM
    ((UILabel *)[cell viewWithTag:4]).text = [dateFormatter stringFromDate:[data valueForKey:@"time"]];
    [dateFormatter setDateFormat:@"d MMM YYYY"];
    ((UILabel *)[cell viewWithTag:5]).text = [dateFormatter stringFromDate:[data valueForKey:@"time"]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
