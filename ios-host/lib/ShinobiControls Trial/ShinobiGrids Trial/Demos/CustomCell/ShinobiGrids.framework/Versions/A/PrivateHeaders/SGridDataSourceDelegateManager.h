// SGridDataSourceDelegateManager.h
#import <Foundation/Foundation.h>
#import "SGridDataSource.h"
#import "SGridDelegate.h"
#import "SGridRowStruct.h"

@class SGridSection;

@interface SGridDataSourceDelegateManager : NSObject {
    @private 
    NSNumber *totalNumberOfColumnsInGrid;
    NSNumber *totalNumberOfSectionsInGrid;
    NSNumber *totalNumberOfRowsInGrid;
    NSMutableArray *numberOfRowsInASection;
    NSMutableArray               *allSections;
    NSMutableDictionary          *colStyles;
    NSMutableDictionary          *rowStyles;
    
    NSMutableArray               *horizontalGridLineStylesGroupedBySection;
    NSMutableArray               *verticalGridLineStyles;
    NSMutableDictionary          *headerStyles;
    
    NSMutableDictionary *liquidSectionHeaderTitles;
    NSMutableDictionary *frozenSectionHeaderTitles;

    NSMutableDictionary *liquidSectionHeaderViews;
    NSMutableDictionary *frozenSectionHeaderViews;
}

@property(nonatomic,retain) ShinobiGrid *owningGrid;

//data source
@property(nonatomic,assign) id<SGridDataSource> dataSource;

//delegate
@property(nonatomic,assign) id<SGridDelegate> delegate;

- (id) initWithGrid:(ShinobiGrid *) grid;
- (void) prepareForReloadFlushingStyles:(BOOL)flushStyles;

#pragma mark -
#pragma mark Data Source Wrapper Methods
- (void) assertDataSourceExists;
- (BOOL) hasDataSource;
- (int) totalNumberOfColumnsInGrid;
- (int) totalNumberOfSectionsInGrid;
- (int) totalNumberOfRowsInGrid;
- (int const) totalNumberOfCellsInGrid;
- (int) numberOfRowsInSection:(int) sectionIndex;
- (void) switchDraggingColWithColAtIndex:(int) indexOfColToSwitchWith withNewOriginOfColToSwitchWith:(float)newOriginOfColToSwitchWith fromCurrentState:(BOOL)fromCurrentState;
- (SGridCell *) loadAndRetrieveCellAtCol:(int)colIndex atRow:(SGridRow)row;

#pragma mark Sections
- (void) assertSectionsValid;
- (SGridSection *) sectionAtIndex:(int)sectionIndex;
- (UIView   *) sectionViewForLiquidSectionAtIndex:(int)sectionIndex inFrame:(CGRect)frame;
- (UIView   *) sectionViewForFrozenSectionAtIndex:(int)sectionIndex inFrame:(CGRect)frame;
- (NSString *) sectionTitleForLiquidSectionAtIndex:(int)sectionIndex;
- (NSString *) sectionTitleForFrozenSectionAtIndex:(int)sectionIndex;

#pragma mark -
#pragma mark Delegate Wrapper Methods
- (BOOL) hasDelegate;
- (SGridColRowStyle *) styleOfCellAtCol:(int) colIndex;
- (SGridColRowStyle *) styleOfCellAtCol:(int) colIndex addToDictionary:(BOOL)add;
- (SGridColRowStyle *) styleOfCellAtRow:(SGridRow)row;
- (void) exchangeRowStyleAtRow:(SGridRow) draggingRow withRowStyleAtRow:(SGridRow) staticRow;
- (void) switchColStyleAtIndex:(int)firstColStyleIndex withColStyleAtIndex:(int) secondColStyleIndex;
- (int) countStoredRowStyles;

//gridlines
- (SGridLineStyle *) gridLineStyleHorizontalAtIndex:(int)gridLineIndex inSection:(int)sectionIndex;
- (SGridLineStyle *) gridLineStyleVerticalAtIndex:(int)gridLineIndex;

//sections
- (SGridSectionHeaderStyle *) sectionHeaderStyleAtIndex:(int) sectionIndex;

#pragma mark -
#pragma mark Methods for Managing Infinite Scrolling

@end
