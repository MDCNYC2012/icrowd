//
//  icNetstatUserTableViewController.m
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "icNetstatUserTableViewController.h"
#import "icNetstatUserTableCell.h"
#import "icDataManager.h"
#import "icUser.h"
#import "icGrain.h"

@interface icNetstatUserTableViewController ()

@end

@implementation icNetstatUserTableViewController

/*
 */
#pragma mark nib/view protocol

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Cloud Nodes", @"Cloud Nodes");
        self.tabBarItem.image = [UIImage imageNamed:@"tabBarIcon-CloudNodes"]; 
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self mainDidUpdateInterval];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setRowHeight:30];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self visdataRelease];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

/*
 */
#pragma mark - icNetstatUserTableViewDelegate

- (void)mainDidUpdateInterval
{
    // if not visible, skip
    if (!self.isViewLoaded || !self.view.window)
        return;
        
    // rebuild the visible data for view objects to consume
    [self visdataRebuild];
    
    // ask the tableView to reload its data
    [self.tableView reloadData];
}

/*
 */
#pragma mark - Data Transform to Local Cache

@synthesize visUsers = _visUsers;

-(void)visdataRebuild
{
    self.visUsers = [[NSArray alloc]init];
    self.visUsers = [[icDataManager singleton] userReadAll];    
}

-(void)visdataRelease
{
    self.visUsers = nil;
}

/*
 */
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int num = [self.visUsers count];
    return num ? num : 0;
}

- (icNetstatUserTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableCellUser:tableView withUser:[self.visUsers objectAtIndex:indexPath.row]];
}

-(icNetstatUserTableCell *) tableCellUser: (UITableView *)tableView withUser: (icUser *) user
{
    icNetstatUserTableCell *cell = [self tableCellInit:tableView withIdentifier:@"UserCell"];
    NSString *brief;
    
    omLogDev(@"%@",[user.grainMostRecent occurredWithinSeconds:IOS_HOST_CLIENT_FEEDBACK_TIMEOUT]);
    // if we have a most recent grain, use it to set the color of the person's cell.
    if (user.hasGrain && [user.grainMostRecent occurredWithinSeconds:IOS_HOST_CLIENT_FEEDBACK_TIMEOUT]) {
        icGrain * grain = user.grainMostRecent;
        float green = [grain.feeling floatValue] + 1;
        if (1<green) green=1;
        float red = 1 - [grain.feeling floatValue];
        if (1<red) red=1;
        green *= [grain.intensity floatValue];
        red *= [grain.intensity floatValue];
        brief = [[NSString alloc] initWithFormat:@"%i grains from %@ yr %@",[user.grain count],user.age,([user.gender isEqualToNumber:[[NSNumber alloc] initWithInt:1]]?@"Female":@"Male")];
        cell.contentView.backgroundColor = [UIColor colorWithRed:red green:green blue:0.f alpha:1.f]; 
        
    // white cell bg
    } else {        
        brief = [[NSString alloc] initWithFormat:@"%@ yr %@",user.age,([user.gender isEqualToNumber:[[NSNumber alloc] initWithInt:1]]?@"Female":@"Male")];        
        cell.contentView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];         
    }
    
    [cell.detailTextLabel setText: brief];
    [cell.detailTextLabel setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.f] ];
    [cell.textLabel setText: user.name]; 
    [cell.textLabel setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.f] ];
    
    return cell;
}

-(icNetstatUserTableCell *) tableCellInit: (UITableView *)tableView withIdentifier: (NSString *)CellIdentifier
{
    
    icNetstatUserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[icNetstatUserTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier]; 
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier]; 
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
