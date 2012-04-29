//
//  ViewController.m
//  CustomCell


#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"
#import "DataSource.h"

@implementation ViewController

#pragma mark Grid Delegate Methods
-(SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForRowAtIndex:(int)rowIndex inSection:(int)sectionIndex{
    SGridColRowStyle *style = [[[SGridColRowStyle alloc] init] autorelease];
    
    style.size = [NSNumber numberWithFloat:100];
    style.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.f];
    
    return style;
}

-(SGridSectionHeaderStyle *)shinobiGrid:(ShinobiGrid *)grid styleForSectionHeaderAtIndex:(int)sectionIndex{
    SGridSectionHeaderStyle *style = [[[SGridSectionHeaderStyle alloc] init] autorelease];
    //Hide the section header
    style.hidden = YES;
    return style;
}

- (UIImage *)convertImageToNegative:(UIImage *)image{
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor whiteColor].CGColor);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height));
    
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();    
    
    return returnImage;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[ self convertImageToNegative:[UIImage imageNamed:@"logo.png"]]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) / 2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
        
        //Create the grid
        grid = [[ShinobiGrid alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-100)];
    } else {
        //Create the grid
        grid = [[ShinobiGrid alloc] initWithFrame:self.view.bounds];
    }
    
//    grid.licenseKey = @"your license key here";
    
    grid.autoresizingMask = ~UIViewAutoresizingNone;
    
    //Create a datasource for the grid
    DataSource *datasource = [[DataSource alloc] init];
    grid.dataSource = datasource;
    [datasource release];
    
    grid.delegate = self;
    
    grid.rowStylesTakePriority = YES;
    
    grid.backgroundColor = [UIColor clearColor];

    //Enable column reordering
    grid.canReorderRowsViaLongPress = NO;
    grid.canReorderColsViaLongPress = NO;
    
    grid.defaultBorderStyle.color = [UIColor colorWithWhite:0.3f alpha:1.f];
    grid.defaultGridLineStyle.color = [UIColor colorWithWhite:0.3f alpha:1.f];
    grid.defaultGridLineStyle.width = 1.f;
    
    grid.layer.cornerRadius = 5.f;
    
    grid.canSelectViaSingleTap = NO;
    
    [self.view addSubview:grid];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
