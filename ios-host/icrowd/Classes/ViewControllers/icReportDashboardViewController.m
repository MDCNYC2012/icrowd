//
//  icrowdReportDashboardViewController.m
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "icReportDashboardViewController.h"

@interface icReportDashboardViewController ()

@end

@implementation icReportDashboardViewController

/*
 */
#pragma icDashboardViewDelegate methods

-(void)mainDidUpdateInterval
{
    
}

/*
 */
#pragma mark nib/view protocol methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Dashboard", @"Dashboard");
        self.tabBarItem.image = [UIImage imageNamed:@"tabBarIcon-Chart"];
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
