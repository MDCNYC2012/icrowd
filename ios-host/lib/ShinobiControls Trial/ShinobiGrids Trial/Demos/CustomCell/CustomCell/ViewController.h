//
//  ViewController.h
//  CustomCell


#import <UIKit/UIKit.h>
#import <ShinobiGrids/ShinobiGrid.h>

@interface ViewController : UIViewController <SGridDelegate> {
    ShinobiGrid *grid;
}

@end
