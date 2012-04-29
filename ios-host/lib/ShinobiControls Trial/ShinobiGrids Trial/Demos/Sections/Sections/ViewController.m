//
//  ViewController.m
//  Sections
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)dealloc {
    [grid release];
    [super dealloc];
}

#pragma mark Grid Delegate Methods
- (SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForRowAtIndex:(int)rowIndex inSection:(int)sectionIndex
{    
    SGridColRowStyle *style = [[[SGridColRowStyle alloc] init] autorelease];
    
    //Set the size and text colour of the first row in the first section
    if (rowIndex == 0 && sectionIndex == 0)
    {
        style.size = [NSNumber numberWithFloat:40];
        style.textColor = [UIColor whiteColor];
        style.font = [UIFont fontWithName:@"TrebuchetMS" size:22];
    } else {
        //Set the size and colour for all rows in all other sections
        style.size = [NSNumber numberWithFloat:36];
        style.backgroundColor = [UIColor whiteColor];
    }
    
    return style;
}

- (SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForColAtIndex:(int)colIndex
{
    SGridColRowStyle *style = [[[SGridColRowStyle alloc] init] autorelease];
    
    //Set fixed width for certain columns
    if(colIndex == 0) {
        style.size = [NSNumber numberWithFloat:100];
        return style;
    } else if(colIndex == 1) {
        style.size = [NSNumber numberWithFloat:200];
        return style;
    } else if (colIndex == 4) {
        style.size = [NSNumber numberWithFloat:120];
        return style;
    }
    
    return nil;
}

-(SGridSectionHeaderStyle *)shinobiGrid:(ShinobiGrid *)grid styleForSectionHeaderAtIndex:(int)sectionIndex{
    SGridSectionHeaderStyle *style = [[[SGridSectionHeaderStyle alloc] init] autorelease];
    
    //Hide the section header for the first section, as it is only column titles
    if(sectionIndex == 0) {
        style.hidden = YES;
    }
    
    style.height = 36;
    style.backgroundColor = [UIColor grayColor];
    return style;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) / 2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        [headerView release];
        
        //Create the grid
        grid = [[ShinobiGrid alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width-100, self.view.bounds.size.height-200)];
    } else {
        //Create the grid
        grid = [[ShinobiGrid alloc] initWithFrame:self.view.bounds];
    }
    
//    grid.licenseKey = @"your license key here";
    
    grid.autoresizingMask = ~UIViewAutoresizingNone;
    
    //Set up the datasource for the grid
    DataSource *datasource = [[DataSource alloc] init];
    grid.dataSource = datasource;
    [datasource release];
    
    grid.delegate = self;
    
    //Tell the grid that the row styling should take preference over column styling
    grid.rowStylesTakePriority = YES;
    
    //Freeze the top row
    [grid freezeRowsAboveAndIncludingRow:SGridRowZero];

    //Enable row reordering
    grid.canReorderRowsViaLongPress = YES;
    
    [self.view addSubview:grid];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
