//
//  icrowdReportDashboardViewController.m
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "icReportDashboardViewController.h"
#import "icReportDashboardDataSource.h"
#import "icDataManager.h"

@interface icReportDashboardViewController ()

@end

@implementation icReportDashboardViewController

/*
 */
#pragma mark properties
@synthesize animateButton;
@synthesize chart;

/*
 */
#pragma icDashboardViewDelegate methods

-(void)mainDidUpdateInterval
{
    // if not visible, skip
    if (!self.isViewLoaded || !self.view.window)
        return;        
    
    // reload all users
    [[icDataManager singleton] userReadAll];    
    
    // IF WE HAVE USERS
    if([[[icDataManager singleton] userArray] count]>=1) {
        // if no chart yet, skip
        if (!self.chart) return;
        //Add the chart to the view controller
        if (!__isChartSubviewAttached) {
            __isChartSubviewAttached = true;
            [self.view addSubview:self.chart];        
        }
        // reload the table data
        [chart reloadData];
        // Trigger a redraw
        [chart redrawChart];
        
    // IF WE DO NOT HAVE USERS
    } else {
        __isChartSubviewAttached = false;
        [self.chart removeFromSuperview];
    }
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

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:246.f/255.f green:246.f/255.f blue:246.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        /*
        // Shinobi Charts logo
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) /2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        headerView = nil;
         */
        
        // Create our chart
        self.chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(20, 20, self.view.bounds.size.width-20, self.view.bounds.size.height-20)];
    } else {
        
        // Create our chart
        self.chart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
    }
    
    // As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    self.chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Initialise the data source we will use for the chart
    datasource = [[icReportDashboardDataSource alloc] init];
    
    // Give the chart the data source
    self.chart.datasource = datasource;
    
    // Create a number axis for the x axis, and disable panning and zooming
    SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] init];
    xAxis.enableGesturePanning = NO;
    xAxis.enableGestureZooming = NO;
    self.chart.xAxis = xAxis;
    xAxis = nil;
    
    // Create a category axis for the y axis, and disable panning and zooming
    SChartCategoryAxis *yAxis  = [[SChartCategoryAxis alloc] init];
    yAxis.enableGesturePanning = NO;
    yAxis.enableGestureZooming = NO;
    
    // The y axis is going to be positioned at this value on the x axis
    yAxis.axisPositionValue = [NSNumber numberWithFloat:barBaseline];
    // The axis tick labels are going to stay at their original position when the axis moves to its designated position
    yAxis.axisLabelsAreFixed = YES;
    self.chart.yAxis = yAxis;
    yAxis = nil;
    
    //Set the chart title
    self.chart.title = @"Bar Series Chart";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        self.chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    }
    self.chart.titleLabel.textColor = [UIColor blackColor];
    
    //Show the legend
    self.chart.legend.hidden = NO;
    self.chart.legend.style.font = [UIFont fontWithName:@"Futura" size:17.0f];
    self.chart.legend.symbolWidth = [NSNumber numberWithInt:75];
    self.chart.legend.style.borderColor = [UIColor clearColor];
    
    // If you have a trial version, you need to enter your licence key here:
    self.chart.licenseKey = SHINOBI_30_DAY_TRIAL_LICENSE;

    
    /*
    // Create the "Animate" button
    CGRect buttonFrame = chart.frame;
    buttonFrame.origin.x += buttonFrame.size.width - 100.0f;
    buttonFrame.origin.y += buttonFrame.size.height - 100.0f;
    self.animateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.animateButton addTarget:self action:@selector(animateBars:) forControlEvents:UIControlEventTouchUpInside];
    [self.animateButton setTitle:@"Animate" forState:UIControlStateNormal];
    self.animateButton.frame = buttonFrame;
    [self.animateButton sizeToFit];
    self.animateButton.autoresizingMask = ~UIViewAutoresizingNone;
    [self.view addSubview: self.animateButton];
     */
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.animateButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [self.animateButton sizeToFit];
    
    // Return YES for supported orientations
    return YES;
}

- (IBAction)animateBars:(id)sender {
    [self mainDidUpdateInterval];
}

@end
