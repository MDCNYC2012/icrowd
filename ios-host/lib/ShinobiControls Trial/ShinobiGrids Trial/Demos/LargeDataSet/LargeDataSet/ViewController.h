//
//  ViewController.h
//  LargeDataSet


#import <UIKit/UIKit.h>
#import <ShinobiGrids/ShinobiGrid.h>
#import "DataSource.h"

@interface ViewController : UIViewController <SGridDelegate> {
    ShinobiGrid *spreadSheet;
}

@end
