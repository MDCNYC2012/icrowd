//
//  BarChartViewController.m
//  BarChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "BarChartViewController.h"

@implementation BarChartViewController

@synthesize animateButton;

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
    [chart release];
    [datasource release];
    [self.animateButton release];
    [super dealloc];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:246.f/255.f green:246.f/255.f blue:246.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Shinobi Charts logo
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) /2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
        
        // Create our chart
        chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-200)];
    } else {
        
        // Create our chart
        chart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
    }
    
    
    
    // As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Initialise the data source we will use for the chart
    datasource = [[BarChartDataSource alloc] init];
    
    // Give the chart the data source
    chart.datasource = datasource;
    
    // Create a number axis for the x axis, and disable panning and zooming
    SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] init];
    xAxis.enableGesturePanning = NO;
    xAxis.enableGestureZooming = NO;
    chart.xAxis = xAxis;
    [xAxis release];
    
    // Create a category axis for the y axis, and disable panning and zooming
    SChartCategoryAxis *yAxis  = [[SChartCategoryAxis alloc] init];
    yAxis.enableGesturePanning = NO;
    yAxis.enableGestureZooming = NO;
    
    // The y axis is going to be positioned at this value on the x axis
    yAxis.axisPositionValue = [NSNumber numberWithFloat:barBaseline];
    // The axis tick labels are going to stay at their original position when the axis moves to its designated position
    yAxis.axisLabelsAreFixed = YES;
    chart.yAxis = yAxis;
    [yAxis release];
    
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
    // chart.licenseKey = @"";
    
    //Add the chart to the view controller
    [self.view addSubview:chart];
    
    // Create the "Animate" button
    CGRect buttonFrame = chart.frame;
    buttonFrame.origin.x += buttonFrame.size.width - 100.0f;
    buttonFrame.origin.y += buttonFrame.size.height - 100.0f;
    self.animateButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] autorelease];
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
    // Reload data to reset the animation
    [chart reloadData];
    // Trigger a redraw so animation will start immediately 
    [chart redrawChart];
}


@end
