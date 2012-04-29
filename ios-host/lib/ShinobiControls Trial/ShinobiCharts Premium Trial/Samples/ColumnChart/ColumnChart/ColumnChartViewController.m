//
//  ColumnChartViewController.m
//  ColumnChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "ColumnChartViewController.h"

@implementation ColumnChartViewController

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) /2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
        
        // Create the chart
        chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-250)];
    } else {
        // Create the chart
        chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50)];
    }
    
    // As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Initialise the data source we will use for the chart
    datasource = [[ColumnChartDataSource alloc] init];
    
    // Give the chart the data source
    chart.datasource = datasource;
    
    // Create a number axis for the y axis, and enable panning and zooming
    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    
    // Enable panning and zooming on Y
    yAxis.enableGesturePanning = NO;
    yAxis.enableGestureZooming = NO;
    
    chart.yAxis = yAxis;
    [yAxis release];
    
    // Create a number axis for the x axis, and enable panning and zooming
    SChartNumberAxis *xAxis =   [[SChartNumberAxis alloc] init];

    
    // Enable panning and zooming on X
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;
    xAxis.enableMomentumPanning = YES;
    xAxis.enableMomentumZooming = YES;
    xAxis.majorTickFrequency = [NSNumber numberWithInt: 1];
    
    xAxis.axisPositionValue = [NSNumber numberWithInt: 0];
    
    chart.xAxis = xAxis;
    [xAxis release];

    SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
    [chart setTheme:midnight];
    [midnight release];
    
    // Set the chart title
    chart.title = @"Column Series Chart";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    }
    chart.titleLabel.textColor = [UIColor whiteColor];
    
    // Show the legend
    chart.legend.hidden = NO;
    chart.legend.style.font = [UIFont fontWithName:@"Futura" size:17.0f];
    chart.legend.symbolWidth = [NSNumber numberWithInt:75];
    chart.legend.style.borderColor = [UIColor clearColor];
    
    // If you have a trial version, you need to enter your licence key here:
    // chart.licenseKey = @"";
    
    // Add the chart to the view controller
    [self.view addSubview:chart];
    
    
    // Create a switch to toggle lineSeries/stepLineSeries
    stackSwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
    [stackSwitch addTarget: self action:(@selector(switchStackingMode)) forControlEvents:UIControlEventValueChanged];
    [stackSwitch setHidden: NO];
    [stackSwitch setAutoresizingMask: ~UIViewAutoresizingNone];
    [self.view addSubview: stackSwitch];
    CGRect switchFrame = CGRectMake(self.view.bounds.size.width/2.f + 5.f,
                                    (self.view.bounds.size.height + chart.frame.origin.y + chart.bounds.size.height)/2.f  - stackSwitch.bounds.size.height,  
                                    stackSwitch.bounds.size.width,
                                    stackSwitch.bounds.size.height);
    [stackSwitch setFrame: switchFrame];
    
    
    // And a label to go with it
    stackLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [stackLabel setHidden: NO];
    [stackLabel setAutoresizingMask: ~UIViewAutoresizingNone];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [stackLabel setFont: [UIFont systemFontOfSize: 24.f]];
    } else {
        [stackLabel setFont: [UIFont systemFontOfSize: 14.f]];
    }
    [stackLabel setText: @"Stacking Columns:"];
    [stackLabel setTextColor: [UIColor whiteColor]];
    [stackLabel setBackgroundColor: [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f]];
    [stackLabel sizeToFit];
    [self.view addSubview: stackLabel];
    CGRect labelFrame = CGRectMake(self.view.bounds.size.width/2.f - stackLabel.bounds.size.width - 5.f,
                                   (self.view.bounds.size.height + chart.frame.origin.y + chart.bounds.size.height)/2.f - stackLabel.bounds.size.height, 
                                   stackLabel.bounds.size.width, 
                                   stackLabel.bounds.size.height);
    [stackLabel setFrame: labelFrame];

}

-(void)switchStackingMode {
    double xMin, xMax;
    xMin = [chart.xAxis.axisRange.minimum doubleValue];
    xMax = [chart.xAxis.axisRange.maximum doubleValue];
       
    // Change series type
    [datasource toggleStackingMode];
    
    // Reload data
    [chart reloadData];
    [chart layoutSubviews];
    
    // Restore axes' ranges
    [chart.xAxis setRangeWithMinimum:[NSNumber numberWithDouble: xMin] andMaximum:[NSNumber numberWithDouble: xMax] withAnimation:NO];
    
    // Redraw chart
    [chart redrawChartAndGL: YES];
}

-(void)dealloc {
    [chart release];
    [datasource release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
