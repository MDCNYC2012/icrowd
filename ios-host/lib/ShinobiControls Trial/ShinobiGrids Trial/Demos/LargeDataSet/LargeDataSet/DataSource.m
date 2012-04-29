//
//  DataSource.m
//  LargeDataSet


#import "DataSource.h"

@implementation DataSource


-(unsigned int)numberOfColsForShinobiGrid:(ShinobiGrid *)grid {
    return 45;
}

-(unsigned int)shinobiGrid:(ShinobiGrid *)grid numberOfRowsInSection:(int)sectionIndex {
    return 10000;
}

-(SGridCell *)shinobiGrid:(ShinobiGrid *)grid cellForGridCoord:(const SGridCoord *)gridCoord{
    
    
    SGridCell *c;
    
    //Populate the first row with title for each column, and apply the header style
    if(gridCoord.row.index == 0 || gridCoord.column == 0)
    {
        SGridTextCell *cell;
        cell = [grid dequeueReusableCellWithIdentifier:@"headerCell"];
        if(cell == nil)
            cell = [[[SGridTextCell alloc] initWithReuseIdentifier:@"headerCell"] autorelease];
        
        cell.textField.textAlignment = UITextAlignmentCenter;
        cell.textField.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.textField.textColor = [UIColor greenColor];
        
        if (gridCoord.column == 0) {
            if (gridCoord.row.index != 0) {
                cell.textField.text = [NSString stringWithFormat:@"%d",gridCoord.row.index];
            }
        } else {
            NSArray *letters = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
            if (gridCoord.column-1 < 26) {
                cell.textField.text = [letters objectAtIndex:gridCoord.column-1];
            } else {
                cell.textField.text = [NSString stringWithFormat:@"A%@",[letters objectAtIndex:(gridCoord.column-1)-26]];
            }
            
            
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cell.textField.font = [UIFont fontWithName:@"Verdana-Bold" size:17.f]; 
        } else {
            cell.textField.font = [UIFont fontWithName:@"Verdana-Bold" size:9.f];  
        }
        
        c = cell;
    }
    else {
        
        SGridArithmeticCell *cell;
        cell = [grid dequeueReusableCellWithIdentifier:@"bodyCell"];
        
        if(cell == nil)
            cell = [[[SGridArithmeticCell alloc] initWithReuseIdentifier:@"bodyCell"] autorelease];
        
        cell.textField.text = @""; 
        cell.textField.font = [UIFont fontWithName:@"Courier" size:15.0f];
        cell.textField.textColor = [UIColor blackColor];
        cell.textField.textAlignment = UITextAlignmentRight;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cell.textField.font = [UIFont fontWithName:@"Courier" size:15.0f];
        } else {
            cell.textField.font = [UIFont fontWithName:@"Courier" size:10.0f];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        
        c = cell;
    }
    
    return c;
}

@end
