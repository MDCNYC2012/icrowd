//
//  TabViewController.m
//
//  Created by on 16/04/2012.
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import "TabViewController.h"
#import <ShinobiCharts/ShinobiChart.h>
#import "SDataSource.h"

@implementation TabViewController

#pragma mark - View lifecycle

- (id)initWithDelegate:(FinancialAppDelegate *)_delegate {
    self = [super init];
    if (self) {
        delegate = _delegate;
        [self view].autoresizingMask = ~UIViewAutoresizingNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
}

-(void)addChart:(ShinobiChart *)chart {
    [[self view] addSubview:chart];
}

-(void)removeChart:(ShinobiChart *)chart {
    for (ShinobiChart *charts in [[self view] subviews]) {
        if (chart==charts) {
            [charts removeFromSuperview];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{return YES;}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
{
}
@end
