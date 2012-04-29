//
//  icReportLinechartDataSource.m
//  icReportLinechartDataSource
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "icReportLinechartViewController.h"
#import "icDataManager.h"

@implementation icReportLinechartViewController

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
        self.title = NSLocalizedString(@"Line Chart", @"Line Chart");
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
    self.view.backgroundColor = [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        /*
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) /2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
         */
        
        //Create the chart
        self.chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-250)];
    } else {
               //Create the chart
        self.chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50)];
    }
    
    // Set a different theme on the chart
    SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
    [self.chart setTheme:midnight];
    
    //As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    self.chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Initialise the data source we will use for the chart
    datasource = [[icReportLinechartDataSource alloc] init];
    
    // Give the chart the data source
    self.chart.datasource = datasource;
    
    // Create a date time axis to use as the x axis.    
    SChartDateTimeAxis *xAxis = [[SChartDateTimeAxis alloc] init];
    
    // Enable panning and zooming on the x-axis.
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;
    xAxis.enableMomentumPanning = YES;
    xAxis.enableMomentumZooming = YES;
    xAxis.axisPositionValue = [NSNumber numberWithInt: 0];
    
    self.chart.xAxis = xAxis;
    
    //Create a number axis to use as the y axis.
    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    
    
    //Enable panning and zooming on Y
    yAxis.enableGesturePanning = YES;
    yAxis.enableGestureZooming = YES;
    yAxis.enableMomentumPanning = YES;
    yAxis.enableMomentumZooming = YES;
    
    self.chart.yAxis = yAxis;
    
    //Set the chart title
    self.chart.title = @"Line Series Chart";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        self.chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    }
    self.chart.titleLabel.textColor = [UIColor whiteColor];
    
    // If you have a trial version, you need to enter your licence key here:
    self.chart.licenseKey = SHINOBI_30_DAY_TRIAL_LICENSE;
    
        
    // Create a switch to toggle lineSeries/stepLineSeries
    
    stepSwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
    [stepSwitch addTarget: self action:(@selector(switchSeriesType)) forControlEvents:UIControlEventValueChanged];
    [stepSwitch setHidden: NO];
    [stepSwitch setAutoresizingMask: ~UIViewAutoresizingNone];
    [self.view addSubview: stepSwitch];
    CGRect switchFrame = CGRectMake(self.view.bounds.size.width/2.f + 5.f,
                                    (self.view.bounds.size.height + self.chart.frame.origin.y + self.chart.bounds.size.height)/2.f - stepSwitch.bounds.size.height,
                                    stepSwitch.bounds.size.width,
                                    stepSwitch.bounds.size.height);
    [stepSwitch setFrame: switchFrame];
    
    
    // And a label to go with it
    stepLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [stepLabel setHidden: NO];
    [stepLabel setAutoresizingMask: ~UIViewAutoresizingNone];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [stepLabel setFont: [UIFont systemFontOfSize: 24.f]];
    } else {
        [stepLabel setFont: [UIFont systemFontOfSize: 14.f]];
    }
    [stepLabel setText: @"Step Line:"];
    [stepLabel setTextColor: [UIColor whiteColor]];
    [stepLabel setBackgroundColor: [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f]];
    [stepLabel sizeToFit];
    [self.view addSubview: stepLabel];
    CGRect labelFrame = CGRectMake(self.view.bounds.size.width/2.f - stepLabel.bounds.size.width - 5.f,
                                   (self.view.bounds.size.height + self.chart.frame.origin.y + self.chart.bounds.size.height)/2.f - stepLabel.bounds.size.height,
                                   stepLabel.bounds.size.width, 
                                   stepLabel.bounds.size.height);
    [stepLabel setFrame: labelFrame];
}

-(void)switchSeriesType {
    double xMin, xMax, yMin, yMax;
    xMin = [self.chart.xAxis.axisRange.minimum doubleValue];
    xMax = [self.chart.xAxis.axisRange.maximum doubleValue];
    yMin = [self.chart.yAxis.axisRange.minimum doubleValue];
    yMax = [self.chart.yAxis.axisRange.maximum doubleValue];
    
    // Change series type
    [datasource toggleSeriesType];
    
    // Reload data
    [self.chart reloadData];
    [self.chart layoutSubviews];
    
    // Restore axes' ranges
    if (xMin<xMax) {
    [self.chart.xAxis setRangeWithMinimum:[NSNumber numberWithDouble: xMin] andMaximum:[NSNumber numberWithDouble: xMax] withAnimation:NO];
    [self.chart.yAxis setRangeWithMinimum:[NSNumber numberWithDouble: yMin] andMaximum:[NSNumber numberWithDouble: yMax] withAnimation:NO];
    }
    
    // Redraw chart
    [self.chart redrawChartAndGL: YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
