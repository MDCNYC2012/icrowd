//
//  PieChartViewController.m
//  PieChart
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.

#import "PieChartViewController.h"

@implementation PieChartViewController

-(id)init {
    [super init];
    if(self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc {
    [pieChart release];
    [donutChart release];
    [datasource release];
    [super dealloc];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Use the chart background color from the default theme for the background color of our view
    self.view.backgroundColor =[UIColor colorWithRed:26.f/255.f green:25.5/255.f blue:25.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) /2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
    } 
    
    // Initialise the data source we will use for the charts
    datasource = [[PieChartDataSource alloc] init];
    
    SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
    
    // Create the pie chart
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        pieChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width/2 -75, self.view.bounds.size.height-200)];
    } else {
        pieChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2, self.view.bounds.size.height)];
    }
    
    
    // As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    pieChart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Give the chart the data source
    pieChart.datasource = datasource;
    
    [pieChart setTheme:midnight];
    
    // Set the chart title
    pieChart.title = @"Pie Chart";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        pieChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        pieChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    }
    pieChart.titleLabel.textColor = [UIColor whiteColor];
    
    // Add the chart to the view controller
    [self.view addSubview:pieChart];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Create the donut chart
        donutChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 +25, 150, self.view.bounds.size.width/2 -75, self.view.bounds.size.height-200)];
    } else {
        // Create the donut chart
        donutChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, 0, self.view.bounds.size.width/2 , self.view.bounds.size.height)];
    }
    
    
    // As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    donutChart.autoresizingMask = ~UIViewAutoresizingNone;
    
    
    // Use the same data source
    donutChart.datasource = datasource;
    
    [donutChart setTheme:midnight];
    
    // Set the chart title
    donutChart.title = @"Donut Chart";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        donutChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        donutChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    }
    donutChart.titleLabel.textColor = [UIColor whiteColor];
    
    // Add the chart to the view controller
    [self.view addSubview:donutChart];
    
    [midnight release];
    
    // If you have a trial version, you need to validate each chart here:
    // pieChart.licenseKey = @"";
    // donutChart.licenseKey = @"";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
