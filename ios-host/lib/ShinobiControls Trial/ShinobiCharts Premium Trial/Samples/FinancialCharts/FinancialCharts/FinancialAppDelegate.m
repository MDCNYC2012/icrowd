//
//
//  Created by on 16/04/2012.
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import "FinancialAppDelegate.h"
#import "SDataSource.h"
#import "TabViewController.h"

@implementation FinancialAppDelegate

@synthesize window;
@synthesize viewController;

- (void)createAnnotationsForChart:(ShinobiChart *)chart {
    
    BOOL darkBackground = [chart.theme isKindOfClass:[SChartMidnightTheme class]];
    
    UIColor *bandColor;
    UIColor *textColor;
    UIColor *textBackground;
    
    // Setup colours
    if (darkBackground) {
        bandColor = [[UIColor redColor] colorWithAlphaComponent:0.2f];
        textColor = [UIColor whiteColor];
    } else {
        bandColor = [UIColor lightGrayColor];
        textColor = [UIColor blackColor];
    }
    
    textBackground = [[UIColor redColor] colorWithAlphaComponent:0.5f];
    
    // Create the recession bands
    SChartAnnotation *recessionBand1 = [SChartAnnotation verticalBandAtPosition:
                                        [NSDate dateWithTimeIntervalSince1970:86400.0 * 365.0 * 31.0] 
                                                                        andMaxX:[NSDate dateWithTimeIntervalSince1970:86400.0 * 365.0 * 33.0] 
                                                                      withXAxis:chart.xAxis andYAxis:chart.yAxis withColor:bandColor];
    
    // Set the annotation to appear below data when rendered
    recessionBand1.position = SChartAnnotationBelowData;
    
    SChartAnnotation *recessionBand2 = [SChartAnnotation verticalBandAtPosition: [NSDate dateWithTimeIntervalSince1970:86400.0 * 365.0 * 38.0] andMaxX:[NSDate dateWithTimeIntervalSince1970:86400.0 * 365.0 * 39.5] withXAxis:chart.xAxis andYAxis:chart.yAxis withColor:bandColor];
    
    // Set the annotation to appear below data when rendered
    recessionBand2.position = SChartAnnotationBelowData;
    
    [chart addAnnotation:recessionBand1];
    [chart addAnnotation:recessionBand2];
    
    // Create the recession labels
    SChartAnnotation *recessionText1 = [SChartAnnotation annotationWithText:@"Recession" andFont:nil withXAxis:chart.xAxis andYAxis:chart.yAxis atXPosition:[NSDate dateWithTimeIntervalSince1970:86400.0 * 365.0 * 32.0] andYPosition:[NSNumber numberWithFloat:7250.0f] withTextColor:textColor withBackgroundColor:textBackground];
    
    SChartAnnotation *recessionText2 = [SChartAnnotation annotationWithText:@"Recession" andFont:nil withXAxis:chart.xAxis andYAxis:chart.yAxis atXPosition:[NSDate dateWithTimeIntervalSince1970:86400.0 * 365.0 * 38.75] andYPosition:[NSNumber numberWithFloat:7250.0f] withTextColor:textColor withBackgroundColor:textBackground];
    
    [chart addAnnotation:recessionText1];
    [chart addAnnotation:recessionText2];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    UIViewController *newViewController;
    
    // Tab 1
    newViewController = [[TabViewController alloc] initWithDelegate:self];
    [newViewController setTitle:@"Candlestick"];
    [viewControllers addObject:newViewController];
    [newViewController release];
    
    // Tab 2
    newViewController = [[TabViewController alloc] initWithDelegate:self];
    [newViewController setTitle:@"OHLC"];
    [viewControllers addObject:newViewController];
    [newViewController release];
    
    // Tab 3
    newViewController = [[TabViewController alloc] initWithDelegate:self];
    [newViewController setTitle:@"Band"];
    [viewControllers addObject:newViewController];
    [newViewController release];
    
    CGRect chartBounds = [[[viewControllers objectAtIndex:0] view] bounds];
    
    // Add a logo above the charts on the ipad 
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView *headerView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView1 setFrame:CGRectMake((chartBounds.size.width - 446) / 2, 0, 446, 92)];
        headerView1.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [[[viewControllers objectAtIndex:0] view] addSubview:headerView1];
        [headerView1 release];
        
        UIImageView *headerView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView2 setFrame:CGRectMake((chartBounds.size.width - 446) / 2, 0, 446, 92)];
        headerView2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [[[viewControllers objectAtIndex:1] view] addSubview:headerView2];
        [headerView2 release];
        
        UIImageView *headerView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView3 setFrame:CGRectMake((chartBounds.size.width - 446) / 2, 0, 446, 92)];
        headerView3.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [[[viewControllers objectAtIndex:2] view] addSubview:headerView3];
        [headerView3 release];
        
        chartBounds = CGRectMake(50, 150, chartBounds.size.width - 100, chartBounds.size.height - 175);
    } 
    
    // Create the candlestick chart
    ShinobiChart *candlestickChart = [[ShinobiChart alloc] initWithFrame:chartBounds
                                                    withPrimaryXAxisType:SChartAxisTypeDateTime
                                                    withPrimaryYAxisType:SChartAxisTypeNumber];
    
    // Create the OHLC chart
    ShinobiChart *ohlcChart = [[ShinobiChart alloc] initWithFrame:chartBounds
                                             withPrimaryXAxisType:SChartAxisTypeDateTime
                                             withPrimaryYAxisType:SChartAxisTypeNumber];
    
    // Create the band chart
    ShinobiChart *bandChart = [[ShinobiChart alloc] initWithFrame:chartBounds
                                             withPrimaryXAxisType:SChartAxisTypeDateTime
                                             withPrimaryYAxisType:SChartAxisTypeNumber];
    
    // If you have a trial version of the framework, set your trial license key here
    // candlestickChart.licenseKey = @"";
    
    // Set the chart titles
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        candlestickChart.title = @"Historical Dow Jones Data in Candlestick style - Pinch to zoom";
        ohlcChart.title = @"Historical Dow Jones Data in OHLC style - Pinch to zoom";
        bandChart.title = @"Historical Dow Jones Data in Band style - Pinch to zoom";
    } else {
        candlestickChart.title = @"^DJI - Pinch to zoom";
        ohlcChart.title = @"^DJI - Pinch to zoom";
        bandChart.title = @"^DJI - Pinch to zoom";
    }
    
    // Use midnight theme for the OHLC and band charts
    SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
    ohlcChart.theme = midnight;
    bandChart.theme = midnight;
    [midnight release];
    
    // Turn on the legends if on iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        candlestickChart.legend.hidden = NO;
        ohlcChart.legend.hidden = NO;
        bandChart.legend.hidden = NO;
    }
    
    // If you have a trial version, you need to validate each chart here:
    // candlestickChart.licenseKey = @"";
    // ohlcChart.licenseKey = @"";
    // bandChart.licenseKey = @"";
    
    // Position the legends below the charts
    candlestickChart.legend.position = SChartLegendPositionBottomMiddle;
    ohlcChart.legend.position = SChartLegendPositionBottomMiddle;
    bandChart.legend.position = SChartLegendPositionBottomMiddle;
    
    // Register charts with the data source object
    SDataSource *dataSource = [[SDataSource alloc] init];
    [dataSource addChart:candlestickChart];
    [dataSource addChart:ohlcChart];
    [dataSource addChart:bandChart];
    
    // Set the data source for the candlestick chart
    candlestickChart.datasource = dataSource;
    candlestickChart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Set axis properties
    candlestickChart.xAxis.enableGesturePanning = YES;
    candlestickChart.xAxis.enableGestureZooming = YES;
    candlestickChart.xAxis.enableMomentumPanning = YES;
    candlestickChart.xAxis.enableMomentumZooming = YES;
    candlestickChart.yAxis.enableGesturePanning = YES;
    candlestickChart.yAxis.enableGestureZooming = YES;
    candlestickChart.yAxis.enableMomentumPanning = YES;
    candlestickChart.yAxis.enableMomentumZooming = YES;
    candlestickChart.xAxis.allowPanningOutOfMaxRange = NO;
    candlestickChart.yAxis.allowPanningOutOfMaxRange = NO;
    candlestickChart.xAxis.style.interSeriesPadding = [NSNumber numberWithFloat:0.075f];
    candlestickChart.xAxis.style.interSeriesSetPadding = [NSNumber numberWithFloat:0.075f];
    candlestickChart.xAxis.style.minorTickStyle.showTicks = NO;
    candlestickChart.yAxis.style.minorTickStyle.showTicks = NO;
    candlestickChart.yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    
    // Use the multi-value tooltip for candlestick chart
    candlestickChart.crosshair.tooltip = [[[SChartCrosshairMultiValueTooltip alloc] init] autorelease];
    
    // Set the data source for the OHLC chart
    ohlcChart.datasource = dataSource;
    ohlcChart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Set axis properties
    ohlcChart.xAxis.enableGesturePanning = YES;
    ohlcChart.xAxis.enableGestureZooming = YES;
    ohlcChart.xAxis.enableMomentumPanning = YES;
    ohlcChart.xAxis.enableMomentumZooming = YES;
    ohlcChart.yAxis.enableGesturePanning = YES;
    ohlcChart.yAxis.enableGestureZooming = YES;
    ohlcChart.yAxis.enableMomentumPanning = YES;
    ohlcChart.yAxis.enableMomentumZooming = YES;
    ohlcChart.xAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    ohlcChart.xAxis.allowPanningOutOfMaxRange = NO;
    ohlcChart.yAxis.allowPanningOutOfMaxRange = NO;
    ohlcChart.xAxis.style.interSeriesPadding = [NSNumber numberWithFloat:0.075f];
    ohlcChart.xAxis.style.interSeriesSetPadding = [NSNumber numberWithFloat:0.075f];
    ohlcChart.xAxis.style.minorTickStyle.showTicks = NO;
    ohlcChart.yAxis.style.minorTickStyle.showTicks = NO;
    ohlcChart.yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    
    // Use the multi-value tooltip for OHLC chart
    ohlcChart.crosshair.tooltip = [[[SChartCrosshairMultiValueTooltip alloc] init] autorelease];
    
    // Set the data source for the band chart
    bandChart.datasource = dataSource;
    bandChart.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Set axis properties
    bandChart.xAxis.enableGesturePanning = YES;
    bandChart.xAxis.enableGestureZooming = YES;
    bandChart.xAxis.enableMomentumPanning = YES;
    bandChart.xAxis.enableMomentumZooming = YES;
    bandChart.yAxis.enableGesturePanning = YES;
    bandChart.yAxis.enableGestureZooming = YES;
    bandChart.yAxis.enableMomentumPanning = YES;
    bandChart.yAxis.enableMomentumZooming = YES;
    bandChart.xAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    bandChart.xAxis.allowPanningOutOfMaxRange = NO;
    bandChart.yAxis.allowPanningOutOfMaxRange = NO;
    bandChart.xAxis.style.minorTickStyle.showTicks = NO;
    bandChart.yAxis.style.minorTickStyle.showTicks = NO;
    bandChart.yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    
    // Use the multi-value tooltip for band chart
    bandChart.crosshair.tooltip = [[[SChartCrosshairMultiValueTooltip alloc] init] autorelease];
    
    [[viewControllers objectAtIndex:0] addChart:candlestickChart];
    [[viewControllers objectAtIndex:1] addChart:ohlcChart];
    [[viewControllers objectAtIndex:2] addChart:bandChart];
    
    // Create annotations for the charts that highlight the recession periods
    [self createAnnotationsForChart:candlestickChart];
    [self createAnnotationsForChart:ohlcChart];
    [self createAnnotationsForChart:bandChart];
    
    [candlestickChart release];
    [ohlcChart release];
    [bandChart release];
    
    [[tabBarController view] setAutoresizingMask: ~UIViewAutoresizingNone];
    [tabBarController setViewControllers:viewControllers];
    [viewControllers release];
    
    [[self window] setRootViewController:tabBarController];
    [[self window] makeKeyAndVisible];
    
    [tabBarController release];
    [dataSource release];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application{}
- (void)applicationWillEnterForeground:(UIApplication *)application{}
- (void)applicationDidBecomeActive:(UIApplication *)application{}
- (void)applicationWillTerminate:(UIApplication *)application{}

- (void)dealloc
{
    [window release];
    [viewController release];
    [super dealloc];
}

@end
