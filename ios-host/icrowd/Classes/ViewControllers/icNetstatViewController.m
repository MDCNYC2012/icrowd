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
#import "icConnectionManager.h"
#import "MainAppDelegate.h"

@interface icNetstatViewController ()

@end

@implementation icNetstatViewController

/*
 */
#pragma mark properties

@synthesize textHostAddressView;
@synthesize textUserCountView;

/*
 */
#pragma mark button handlers

-(void)flushWasPressed: (id) sender
{
    omLogDev(@"Flush was pressed.");
    [[icDataManager singleton] flushDatabase];
}

/*
 */
#pragma mark icCloudStatusViewDelegate protocol
-(void)mainDidUpdateInterval
{
    // if not visible, skip
    if (!self.isViewLoaded || !self.view.window)
        return;
    
    // set text of user count
    [self.textUserCountView setText:
     [[NSString alloc] initWithFormat:@"%i",
      [[[icDataManager singleton] userArray] count]
      ]];
}


/*
 */
#pragma mark nib / view protocol

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Cloud Status", @"Cloud Status");
        self.tabBarItem.image = [UIImage imageNamed:@"tabBarIcon-CloudStatus"]; 
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
        
    // navigation button: flush database
    UIBarButtonItem *flushButton = [[UIBarButtonItem alloc] initWithTitle:@"Flush Cloud" style:UIBarButtonItemStylePlain target:self action:@selector(flushWasPressed:)];
    self.navigationItem.leftBarButtonItem = flushButton;
    
    // get ip address and set it up
    NSString * hostAddress = [[NSString alloc] initWithFormat:@"http:// %@ : %i /",[[icConnectionManager singleton] getIPAddress],IOS_HOST_SERVER_PORT];
    [self.textHostAddressView setText:hostAddress];
        
    // set main view to user table view
    /*
    icNetstatUserTableViewController * viewController = [[icNetstatUserTableViewController alloc]init];
    [self addChildViewController:viewController];
    [self setView:viewController.tableView];
     */
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTextHostAddressView:nil];
    [self setTextUserCountView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
