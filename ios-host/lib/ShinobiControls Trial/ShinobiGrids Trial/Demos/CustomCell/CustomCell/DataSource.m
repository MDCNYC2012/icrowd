//
//  DataSource.m
//  CustomCell


#import "DataSource.h"

NSString *const kReuseIdentifier = @"MyCell";

@implementation DataSource
@synthesize reuseIdentifiers;

- (SGridCell *)shinobiGrid:(ShinobiGrid *)grid cellForGridCoord:(const SGridCoord *) gridCoord{
    if (self.reuseIdentifiers == nil) {
        self.reuseIdentifiers = [NSMutableArray arrayWithObjects:@"UIImage", @"UISwitch", @"UISlider", @"UISegmentedControl", @"UILabel", @"UIButton", nil];
    }
    
    SGridCell *cell;
    
    if (gridCoord.column == 0) {
        
        SGridCell *textCell;
        
        //we use one reuse identifier for all the cells in column 0 as they all have the same type of content 
        textCell = [grid dequeueReusableCellWithIdentifier:@"textCell"];
        
        if(textCell == nil)
            textCell = [[[SGridTextCell alloc] initWithReuseIdentifier:@"textCell"] autorelease];
        
        textCell.fitSubviewsToView = NO;
        
        
        UILabel *textField;
        if (textCell.subviews.count == 0) {
            textField = [[UILabel alloc] init];
            [textCell addSubview:textField];
            [textField release];
        } else {
            textField = [textCell.subviews lastObject];
        }

        textField.backgroundColor = [UIColor clearColor];
        textField.textColor = [UIColor colorWithWhite:0.85f alpha:1.f];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            textField.font = [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:19.f];
        } else {
            textField.font = [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:12.f];
        }
        
        textField.text = [self.reuseIdentifiers objectAtIndex:gridCoord.rowIndex];
                
        cell = textCell;
        
    } else {
        
        SGridCell *customCell;
        //all the cells in column 1 have different content types, so we use a different reuse identifier for each
        customCell = [grid dequeueReusableCellWithIdentifier:[self.reuseIdentifiers objectAtIndex:gridCoord.rowIndex
                                                              ]];
        
        if(customCell == nil)
            customCell = [[[SGridCell alloc] initWithReuseIdentifier:[self.reuseIdentifiers objectAtIndex:gridCoord.rowIndex
                                                                      ]] autorelease];
        
        //remove any previous objects
        for (UIView *v in customCell.subviews) {
            [v removeFromSuperview];
        }
        
        UIView *cellContent;
                
        if ( UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                cellContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 450, 100)];
            } else {
                cellContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
            }
        } else {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                cellContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 350, 100)];
            } else {
                cellContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
            }
         }
        
        customCell.fitSubviewsToView = NO;
        
        if(gridCoord.rowIndex == 0) {
            UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_retina.png"]];
            iv.frame = CGRectMake((cellContent.frame.size.width / 2) - 37.5f, 10, 75, 75);
            iv.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            [cellContent addSubview:iv];
            [iv release];
        } else if (gridCoord.rowIndex == 1) {
            UISwitch *aSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake((cellContent.frame.size.width / 2) - 42, 35, 100, 30)] autorelease];
            aSwitch.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            aSwitch.on = YES;
            [cellContent addSubview:aSwitch];
            
        } else if (gridCoord.rowIndex == 2) {
            UISlider *slider = [[[UISlider alloc] initWithFrame:CGRectMake((cellContent.frame.size.width / 2) - 50, 35, 100, 30)] autorelease];
            slider.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            slider.value = 0.5f;
            [cellContent addSubview:slider];
            
        } else if (gridCoord.rowIndex == 3) {
            UISegmentedControl *segment = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"A", @"B", @"C", nil]] autorelease];
            segment.frame = CGRectMake((cellContent.frame.size.width / 2) - 50, 35, 100, 30);
            segment.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            segment.selectedSegmentIndex = 1;
            [cellContent addSubview:segment];
            
        } else if (gridCoord.rowIndex == 4) {
            UILabel *labels[2];
                
            for(int i = 0; i < 2; i++){
                labels[i] = [[[UILabel alloc] init] autorelease];
                
                labels[i].text = [NSString stringWithFormat:@"Label %d", i];
                labels[i].autoresizingMask = ~UIViewAutoresizingNone;
                labels[i].textAlignment = UITextAlignmentCenter;
                
                labels[i].frame = CGRectMake(30.f*(i+1), 30.f*(i+1), 100, 25);
                
                [cellContent addSubview:labels[i]];
            }
            
            labels[0].backgroundColor = [UIColor magentaColor];
            labels[1].backgroundColor = [UIColor cyanColor];
            
            
        } else if (gridCoord.rowIndex == 5) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake((cellContent.frame.size.width / 2) - 40, 35, 80, 30);
            [button setTitle:@"Button" forState:UIControlStateNormal];
            button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            
            [cellContent addSubview:button];
            
        }
        [customCell addSubview:cellContent];
        [cellContent release];

        
        cell = customCell;
    }

    return cell;
}

- (unsigned int)shinobiGrid:(ShinobiGrid *) grid numberOfRowsInSection:(int) sectionIndex{
    return 6;
}

- (unsigned int) numberOfColsForShinobiGrid:(ShinobiGrid *)grid {
    return 2;
}

- (void) dealloc {
    [reuseIdentifiers release];
    [super dealloc];
}


@end
