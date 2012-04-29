//
//  LineChartViewController.m
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "LineChartViewController.h"

@implementation LineChartViewController

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
        
        //Create the chart
        chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-250)];
    } else {
               //Create the chart
        chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50)];
    }
    
    // Set a different theme on the chart
    SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
    [chart setTheme:midnight];
    [midnight release];
    
    //As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Initialise the data source we will use for the chart
    datasource = [[LineChartDataSource alloc] init];
    
    // Give the chart the data source
    chart.datasource = datasource;
    
    // Create a date time axis to use as the x axis.    
    SChartDateTimeAxis *xAxis = [[SChartDateTimeAxis alloc] init];
    
    // Enable panning and zooming on the x-axis.
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;
    xAxis.enableMomentumPanning = YES;
    xAxis.enableMomentumZooming = YES;
    xAxis.axisPositionValue = [NSNumber numberWithInt: 0];
    
    chart.xAxis = xAxis;
    [xAxis release];
    
    //Create a number axis to use as the y axis.
    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    
    
    //Enable panning and zooming on Y
    yAxis.enableGesturePanning = YES;
    yAxis.enableGestureZooming = YES;
    yAxis.enableMomentumPanning = YES;
    yAxis.enableMomentumZooming = YES;
    
    chart.yAxis = yAxis;
    
    //Set the chart title
    chart.title = @"Line Series Chart";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
    } else {
        chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
    }
    chart.titleLabel.textColor = [UIColor whiteColor];
    
    // If you have a trial version, you need to enter your licence key here:
    chart.licenseKey = @"APiwO7PoSQnah4rMjAxMjA1MjlpbmZvQHNoaW5vYmljb250cm9scy5jb20=zTj/qmUhRtCDu7ZH8HaAw03w5MWUSRPjbeZqUp7z9HhIVMepQEk7KQSCD1bQPqyXI29laU0+feWvcHANlMbJJodIP8djsOIzH6nqh4uJ05r2WrTbeypIXF/sgtLBi6tlipazqsQ6ClXnDgD7L++waj+pyghw=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";
    
    // Add the chart to the view controller
    [self.view addSubview:chart];
    
    
    // Create a switch to toggle lineSeries/stepLineSeries
    
    stepSwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
    [stepSwitch addTarget: self action:(@selector(switchSeriesType)) forControlEvents:UIControlEventValueChanged];
    [stepSwitch setHidden: NO];
    [stepSwitch setAutoresizingMask: ~UIViewAutoresizingNone];
    [self.view addSubview: stepSwitch];
    CGRect switchFrame = CGRectMake(self.view.bounds.size.width/2.f + 5.f,
                                    (self.view.bounds.size.height + chart.frame.origin.y + chart.bounds.size.height)/2.f - stepSwitch.bounds.size.height,
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
                                   (self.view.bounds.size.height + chart.frame.origin.y + chart.bounds.size.height)/2.f - stepLabel.bounds.size.height,
                                   stepLabel.bounds.size.width, 
                                   stepLabel.bounds.size.height);
    [stepLabel setFrame: labelFrame];
}

-(void)switchSeriesType {
    double xMin, xMax, yMin, yMax;
    xMin = [chart.xAxis.axisRange.minimum doubleValue];
    xMax = [chart.xAxis.axisRange.maximum doubleValue];
    yMin = [chart.yAxis.axisRange.minimum doubleValue];
    yMax = [chart.yAxis.axisRange.maximum doubleValue];
    
    // Change series type
    [datasource toggleSeriesType];
    
    // Reload data
    [chart reloadData];
    [chart layoutSubviews];
    
    // Restore axes' ranges
    [chart.xAxis setRangeWithMinimum:[NSNumber numberWithDouble: xMin] andMaximum:[NSNumber numberWithDouble: xMax] withAnimation:NO];
    [chart.yAxis setRangeWithMinimum:[NSNumber numberWithDouble: yMin] andMaximum:[NSNumber numberWithDouble: yMax] withAnimation:NO];
    
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
