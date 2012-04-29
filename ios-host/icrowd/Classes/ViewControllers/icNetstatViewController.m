//
//  icrowdNetstatViewController.m
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

// TODO: @sel flushWasPressed throw a safety "are you sure" dialog
#pragma mark -

#import "icNetstatViewController.h"
#import "icNetstatUserTableViewController.h"
#import "icDataManager.h"

@interface icNetstatViewController ()

@end

@implementation icNetstatViewController

/*
 */
#pragma mark navigation bar delegate
-(void)flushWasPressed: (id) sender
{
    omLogDev(@"Flush was pressed.");
    [[icDataManager singleton] flushDatabase];
}


/*
 */
#pragma mark nib / view protocol

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Cloud Status", @"Cloud Status");
        self.tabBarItem.image = [UIImage imageNamed:@"tabBarIcon-Cloud"]; 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigation button: flush database
    UIBarButtonItem *flushButton = [[UIBarButtonItem alloc] initWithTitle:@"Flush Database" style:UIBarButtonItemStylePlain target:self action:@selector(flushWasPressed:)];
    self.navigationItem.leftBarButtonItem = flushButton;
        
    // set main view to user table view
    icNetstatUserTableViewController * viewController = [[icNetstatUserTableViewController alloc]init];
    [self addChildViewController:viewController];
    [self setView:viewController.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
