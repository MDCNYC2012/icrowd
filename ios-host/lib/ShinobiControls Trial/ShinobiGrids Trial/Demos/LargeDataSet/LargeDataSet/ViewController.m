//
//  ViewController.m
//  LargeDataSet


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>



@implementation ViewController


#pragma mark - SGridDelegate methods
-(SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForColAtIndex:(int)colIndex {
    //Create the style for columns
    SGridColRowStyle *style = [[[SGridColRowStyle alloc] init] autorelease];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        style.size = [NSNumber numberWithFloat:100];
    } else {
        style.size = [NSNumber numberWithFloat:50];
    }
    
    return style;
}

-(SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForRowAtIndex:(int)rowIndex inSection:(int)sectionIndex {
    
    //Create the style for rows
    SGridColRowStyle *style = [[[SGridColRowStyle alloc] init] autorelease];
    
    style.backgroundColor = [UIColor redColor];
    style.textColor = [UIColor blackColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        style.size = [NSNumber numberWithFloat:30];
    } else {
        style.size = [NSNumber numberWithFloat:20];
    }
        
    return  style;
}

-(SGridSectionHeaderStyle *)shinobiGrid:(ShinobiGrid *)grid styleForSectionHeaderAtIndex:(int)sectionIndex {
    //Create a style for section headers
    SGridSectionHeaderStyle *style = [[[SGridSectionHeaderStyle alloc] init] autorelease];
    style.hidden = YES;
    return style;
}

- (void)shinobiGrid:(ShinobiGrid *)grid willSelectCellAtCoord:(const SGridCoord *)gridCoord {
    
   //if we tap on a header (top or left) do nothing
    if (gridCoord.column == 0 || gridCoord.rowIndex == 0) {
        return;
    }
    
    SGridCell *c = [grid visibleCellAtCol:gridCoord.column andRow:gridCoord.row];
    c.backgroundColor = [UIColor whiteColor];
    
    
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
        
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [iv setImage:[UIImage imageNamed:@"ios-linen.png"]];
    iv.autoresizingMask = ~UIViewAutoresizingNone;
    [self.view addSubview:iv];
    [iv release];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) / 2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
        
        //Create the grid
        spreadSheet = [[ShinobiGrid alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-200)];
    } else {
        //Create the grid
        spreadSheet = [[ShinobiGrid alloc] initWithFrame:self.view.bounds];
    }
    
//    spreadSheet.licenseKey = @"your license key here";
    
    spreadSheet.autoresizingMask = ~UIViewAutoresizingNone;
    
    //Setup the data source for the grid
    DataSource *datasource = [[DataSource alloc] init];
    spreadSheet.dataSource = datasource;
    [datasource release];
    
    //Freeze our top and left most rows
    [spreadSheet freezeRowsAboveAndIncludingRow:SGridRowMake(0, 0)];
    [spreadSheet freezeColsToTheLeftOfAndIncludingIndex:0];
    
    spreadSheet.delegate = self;
    
    //Some basic grid styling
    spreadSheet.backgroundColor = [UIColor clearColor];
    spreadSheet.rowStylesTakePriority = YES;
    spreadSheet.defaultGridLineStyle.width = 1.0f;
    spreadSheet.defaultGridLineStyle.color = [UIColor lightGrayColor];
    spreadSheet.defaultBorderStyle.color = [UIColor darkGrayColor];
    spreadSheet.defaultBorderStyle.width = 1.0f;
    [spreadSheet.layer setCornerRadius:10.f];
   
    //We want to be able to edit our cells
    spreadSheet.canEditCellsViaDoubleTap = YES;
    
    //Disable all dragging - we don't want to be able to reorder in any direction
    spreadSheet.canReorderColsViaLongPress = NO;
    spreadSheet.canReorderRowsViaLongPress = NO;
    
    [self.view addSubview:spreadSheet];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
