//
//  ViewController.m
//  SimpleGrid
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController


#pragma mark Grid Delegate methods
// Column and Row Styling
- (SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForRowAtIndex:(int)rowIndex inSection:(int) sectionIndex
{    
    SGridColRowStyle *style = [[[SGridColRowStyle alloc] init] autorelease];
    //Set the size and text colour of the first row
    if (rowIndex == 0)
    {
        style.size = [NSNumber numberWithInt:40]; 
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            style.size = [NSNumber numberWithInt:36]; 
        } else {
            style.size = [NSNumber numberWithInt:26]; 
        }
    }
    
    style.backgroundColor = [UIColor whiteColor];
    return style;
}

- (SGridSectionHeaderStyle *)shinobiGrid:(ShinobiGrid *)grid styleForSectionHeaderAtIndex:(int) sectionIndex {
    SGridSectionHeaderStyle *s = [[[SGridSectionHeaderStyle alloc] initWithHeight:0.f withBackgroundColor:[UIColor clearColor]] autorelease];
    return s;
}
                                                                                                              

- (void)shinobiGrid:(ShinobiGrid *)grid willSelectCellAtCoord:(const SGridCoord *)gridCoord {
    
    for (int i=0; i< 14; i++) {
        
        SGridRow r;
        r.index = i;
        r.section = 0;
            
        SGridCell *c0 = [grid visibleCellAtCol:0 andRow:r];
        c0.backgroundColor = [UIColor clearColor];
        
        SGridCell *c1 = [grid visibleCellAtCol:1 andRow:r];
        c1.backgroundColor = [UIColor clearColor];
    }
    
    
    SGridCell *c0 = [grid visibleCellAtCol:0 andRow:gridCoord.row];
    c0.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3f];
    
    SGridCell *c1 = [grid visibleCellAtCol:1 andRow:gridCoord.row];
    c1.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3f];
}

#pragma mark handler for switch
-(void)toggleReordering:(id)sender{
    simpleGrid.canReorderRowsViaLongPress = ((UISwitch *)sender).on;
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
    
    self.view.backgroundColor = [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) / 2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
        
        //Create the grid
        simpleGrid = [[ShinobiGrid alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-150)];
        
    } else {
        //Create the grid
        simpleGrid = [[ShinobiGrid alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50)];
    }
    
//    simpleGrid.licenseKey = @"your license key here";
    
    simpleGrid.autoresizingMask = ~UIViewAutoresizingNone;
    
    //Create the datasource for the grid
    DataSource *datasource = [[DataSource alloc] init];
    simpleGrid.dataSource = datasource;
    [datasource release];
    
    simpleGrid.delegate = self;
        
    //Tell the grid that row styling should take preference over column styling
    simpleGrid.rowStylesTakePriority = YES;
    
    simpleGrid.defaultGridLineStyle.width = 1.0f;
    simpleGrid.defaultGridLineStyle.color = [UIColor lightGrayColor];
    
    //Freeze the top row in place, as it is serving as a header.
    [simpleGrid freezeRowsAboveAndIncludingRow:SGridRowZero];
    
    
    simpleGrid.defaultBorderStyle.color = [UIColor darkGrayColor];
    simpleGrid.defaultBorderStyle.width = 10.0f;
    simpleGrid.layer.cornerRadius = 10.f;
    
    simpleGrid.canReorderRowsViaLongPress = YES;

    //Add everything to view
    [self.view addSubview:simpleGrid];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
