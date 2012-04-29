//
//  ViewController.h
//  SimpleGrid
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiGrids/ShinobiGrid.h>
#import "DataSource.h"

@interface ViewController : UIViewController <SGridDelegate> {
    ShinobiGrid *simpleGrid;
}

@end
