//
//  LargeDataSetViewController.m
//  LargeDataSet
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import "LargeDataSetViewController.h"

@implementation LargeDataSetViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc {
    [chart release];
    [datasource release];
    [boxZoomSwitch release];
	[super dealloc];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) /2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
        chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-200)];
        
    } else {
        chart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
    }
    
    //As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    //Initialise the data source we will use for the chart
    datasource = [[LargeDataSetDataSource alloc] init];
    
    //Give the chart the data source
    chart.datasource = datasource;
    chart.delegate = self;
    
    //Set a different theme on the chart, the following are provided:
    //SChartTheme (default theme, this is used when no theme is specified)
    //SChartMightnightTheme
    SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
    [chart setTheme:midnight];
    [midnight release];
    
    SChartNumberRange *xRange = [[SChartNumberRange alloc] initWithMinimum:[NSNumber numberWithInt: 3694] andMaximum:[NSNumber numberWithInt:3821]];
    
    //Create a number axis to use as the x axis.    
    SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] initWithRange:xRange];
    [xRange release];
    
    //Enable panning and zooming on X
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;
    
    //Enable pan and zoom momentum on X
    xAxis.enableMomentumPanning = YES;
    xAxis.enableMomentumZooming = YES;

    chart.xAxis = xAxis;
    [xAxis release];
    
    SChartNumberRange *yRange = [[SChartNumberRange alloc] initWithMinimum:[NSNumber numberWithInt: 150] andMaximum:[NSNumber numberWithInt:350]];
    
    //Create a number axis to use as the y axis.
    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] initWithRange: yRange];
    [yRange release];
    
    //Enable panning and zooming on Y
    yAxis.enableGesturePanning = YES;
    yAxis.enableGestureZooming = YES;
    
    //Enable pan and zoom momentum on Y
    yAxis.enableMomentumPanning = YES;
    yAxis.enableMomentumZooming = YES;
    
    // Diagonal tick labels on y-axis
    yAxis.style.majorTickStyle.tickLabelOrientation = TickLabelOrientationDiagonal;
    
    chart.yAxis = yAxis;
    [yAxis release];
    
    chart.gestureDoubleTapResetsZoom = YES;
    
    //Set the chart title
    chart.title = @"Large Data Set - 20,000 Points";
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];   
    }
    chart.titleLabel.textColor = [UIColor whiteColor];
    
    // If you have a trial version, you need to enter your licence key here:
    // chart.licenseKey = @"";
    
    //Show the legend
    chart.legend.hidden = NO;
    
    //Additional legend config
    chart.legend.style.font = [UIFont fontWithName:@"Futura" size:17.0f];
    chart.legend.symbolWidth = [NSNumber numberWithInt:75];
    chart.legend.style.borderColor = [UIColor clearColor];
    
    //Add the chart to the view controller
    [self.view addSubview:chart];
    
    // UISwitch to toggle box zoom mode
    boxZoomSwitch = [[UISwitch alloc] init];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        boxZoomSwitch.center = (CGPoint){chart.frame.origin.x + chart.frame.size.width - 1.2f*boxZoomSwitch.frame.size.width, self.view.bounds.size.height/2.f};
    } else {
        boxZoomSwitch.center = (CGPoint){chart.frame.origin.x + chart.frame.size.width - 0.6f*boxZoomSwitch.frame.size.width, self.view.bounds.size.height/2.f};
    }
    boxZoomSwitch.autoresizingMask = ~(UIViewAutoresizingNone|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin);
    boxZoomSwitch.hidden = NO;
    [boxZoomSwitch addTarget:self action:@selector(toggleBoxZoom:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:boxZoomSwitch];
    
    // And a label to go with it
    UILabel *switchLabel = [[UILabel alloc] initWithFrame:boxZoomSwitch.frame];
    [switchLabel setFrame:(CGRect){switchLabel.frame.origin.x,switchLabel.frame.origin.y-30.f,switchLabel.frame.size.width, switchLabel.frame.size.height}];
    switchLabel.text = @"Box Zoom";
    switchLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    switchLabel.textColor = [UIColor whiteColor];
    switchLabel.textAlignment = UITextAlignmentCenter;
    switchLabel.backgroundColor = [UIColor clearColor];
    switchLabel.autoresizingMask = ~(UIViewAutoresizingNone|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin);
    switchLabel.hidden = NO;
    [self.view addSubview:switchLabel];
    
    boxZoomEnabled = NO;
}

-(void)toggleBoxZoom:(UISwitch *)sender {
    boxZoomEnabled = !boxZoomEnabled;
    [boxZoomSwitch setOn:boxZoomEnabled];
    if (boxZoomEnabled) {
        chart.gesturePanType = SChartGesturePanTypeBoxDraw;
    } else {
        chart.gesturePanType = SChartGesturePanTypePanPinch;
    }
}

// After performing a box zoom, disable box zoom mode
-(void)sChartDidBoxZoom:(ShinobiChart *)chart {
    [self toggleBoxZoom:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return UIDeviceOrientationIsLandscape(interfaceOrientation);
    }
}

@end
