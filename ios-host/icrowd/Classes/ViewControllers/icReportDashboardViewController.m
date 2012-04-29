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
    // reload chart data
    [chart reloadData];
    // Trigger a redraw
    [chart redrawChart];

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
        chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(20, 20, self.view.bounds.size.width-20, self.view.bounds.size.height-20)];
    } else {
        
        // Create our chart
        chart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
    }
    
    
    
    // As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Initialise the data source we will use for the chart
    datasource = [[icReportDashboardDataSource alloc] init];
    
    // Give the chart the data source
    chart.datasource = datasource;
    
    // Create a number axis for the x axis, and disable panning and zooming
    SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] init];
    xAxis.enableGesturePanning = NO;
    xAxis.enableGestureZooming = NO;
    chart.xAxis = xAxis;
    xAxis = nil;
    
    // Create a category axis for the y axis, and disable panning and zooming
    SChartCategoryAxis *yAxis  = [[SChartCategoryAxis alloc] init];
    yAxis.enableGesturePanning = NO;
    yAxis.enableGestureZooming = NO;
    
    // The y axis is going to be positioned at this value on the x axis
    yAxis.axisPositionValue = [NSNumber numberWithFloat:barBaseline];
    // The axis tick labels are going to stay at their original position when the axis moves to its designated position
    yAxis.axisLabelsAreFixed = YES;
    chart.yAxis = yAxis;
    yAxis = nil;
    
    //Set the chart title
    chart.title = @"Bar Series Chart";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    }
    chart.titleLabel.textColor = [UIColor blackColor];
    
    //Show the legend
    chart.legend.hidden = NO;
    chart.legend.style.font = [UIFont fontWithName:@"Futura" size:17.0f];
    chart.legend.symbolWidth = [NSNumber numberWithInt:75];
    chart.legend.style.borderColor = [UIColor clearColor];
    
    // If you have a trial version, you need to enter your licence key here:
    chart.licenseKey = @"APiwO7PoSQnah4rMjAxMjA1MjlpbmZvQHNoaW5vYmljb250cm9scy5jb20=zTj/qmUhRtCDu7ZH8HaAw03w5MWUSRPjbeZqUp7z9HhIVMepQEk7KQSCD1bQPqyXI29laU0+feWvcHANlMbJJodIP8djsOIzH6nqh4uJ05r2WrTbeypIXF/sgtLBi6tlipazqsQ6ClXnDgD7L++waj+pyghw=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";
    
    //Add the chart to the view controller
    [self.view addSubview:chart];
    
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
