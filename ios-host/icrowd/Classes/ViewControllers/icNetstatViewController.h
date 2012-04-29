//
//  icrowdNetstatViewController.h
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "global.h"
#import <UIKit/UIKit.h>

@class icDataManager;

#pragma mark - icCloudStatusViewDelegate protocol
@protocol icCloudStatusViewDelegate <NSObject>
-(void)mainDidUpdateInterval;
@end

#pragma mark interface
@interface icNetstatViewController : UIViewController <icCloudStatusViewDelegate>

#pragma mark properties
@property (strong, nonatomic) IBOutlet UITextView *textHostAddressView;
@property (strong, nonatomic) IBOutlet UITextView *textUserCountView;

#pragma mark button handlers
-(void)flushWasPressed:(id)sender;

@end
