//
//  DataSource.m
//  DragAndDropGrid
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import "DataSource.h"

NSString *const kReuseIdentifier = @"MyCell";

@implementation DataSource

-(id)init {
    self = [super init];
    if (self) {
        //Set up some canned data to represent rising & falling stocks

        struct RiseFallData {
            NSString *symbol, *name;
            float price, change, changePercent, volume;
        };
       
        struct RiseFallData risingData[] = {
            {  @"AMEC",  @"AMEC PLC",          1103.00,  32.00,  2.99,  1147088  },
            {  @"PFC",   @"PETROFAC LTD",      1513.00,  42.00,  2.86,  506152   },
            {  @"BG",    @"BG GROUP PLC",      1484.00,  38.00,  2.63,  6748064  },
            {  @"TLW",   @"TULLOW OIL",        1514.00,  31.00,  2.09,  1744825  },
            {  @"WOS",   @"WOLSELEY PLC",      2268.00,  37.00,  1.66,  414976   },
            {  @"SDR",   @"SCHRODERS PLC",     1635.00,  25.00,  1.55,  218181   },
            {  @"STAN",  @"STANDARD CHARTER",  1620.50,  23.50,  1.47,  1976132  },
            {  @"WTB",   @"WHITBREAD PLC",     1708.00,  24.00,  1.43,  179562   },
            {  @"SAB",   @"SABMILLER PLC",     2534.50,  27.50,  1.10,  1271779  },
            {  @"RB",    @"RECKITT BENCKISE",  3514.00,  35.00,  1.01,  969352   },
            {  nil,      nil,                     0.00,   0.00,  0.00,  000000   },
        };
        
        struct RiseFallData fallingData[] = {
            {  @"EVR",   @"EVRAZ PLC",         428.00,        -14.00,  -3.17,   1200320  },
            {  @"TATE",  @"TATE & LYLE",       674.00,        -21.00,  -3.02,   2048095  },
            {  @"RR",    @"ROLLS-ROYCE HOLD",  764.50,        -20.50,  -2.61,   9478947  },
            {  @"BLND",  @"BRIT LAND CO PLC",  497.40,        -10.60,  -2.09,   2775659  },
            {  @"IAP",   @"ICAP PLC",          382.30,        -6.70,   -1.72,   1325496  },
            {  @"RIO",   @"RIO TINTO PLC",     3833.00,       -40.50,  -1.05,   3549046  },
            {  @"BLT",   @"BHP BILLITON PLC",  2112.50,       -17.50,  -0.82,   4162720  },
            {  @"NXT",   @"NEXT PLC",          2704.00,       -18.00,  -0.66,   367627   },
            {  @"JMAT",  @"JOHNSON MATTHEY",   2244.00,       -13.00,  -0.58,   352766   },
            {  @"ITRK",  @"INTERTEK GROUP",    2170.00,       -9.00,   -0.41,   111979   },
            {  nil,      nil,                     0.00,        0.00,    0.00,   000000   },
        };

        risers  = [[NSMutableArray alloc] init];
        fallers = [[NSMutableArray alloc] init];

        for(int i = 0; risingData[i].symbol; i++){
            Stock *stock = [[[Stock alloc]
                initWithSymbol:risingData[i].symbol
                       andName:risingData[i].name
                      andPrice:[NSNumber numberWithFloat:risingData[i].price]
                     andChange:[NSNumber numberWithFloat:risingData[i].change]
              andChangePercent:[NSNumber numberWithFloat:risingData[i].changePercent]
                     andVolume:[NSNumber numberWithFloat:risingData[i].volume]] autorelease];

            [risers addObject:stock];
        }

        for(int i = 0; fallingData[i].symbol; i++){
            Stock *stock = [[[Stock alloc]
                initWithSymbol:fallingData[i].symbol
                       andName:fallingData[i].name
                      andPrice:[NSNumber numberWithFloat:fallingData[i].price]
                     andChange:[NSNumber numberWithFloat:fallingData[i].change]
              andChangePercent:[NSNumber numberWithFloat:fallingData[i].changePercent]
                     andVolume:[NSNumber numberWithFloat:fallingData[i].volume]] autorelease];

            [fallers addObject:stock];
        }
                    
    }
    
    return self;
}

//Returns the number of columns in the specified grid
-(unsigned int) numberOfColsForShinobiGrid:(ShinobiGrid *)grid {
    return 5;
}

//Return the number of sections in the specified grid
-(unsigned int) numberOfSectionsInShinobiGrid:(ShinobiGrid *)grid {
    //Risers section, fallers section, and a section for the column titles
    return 3;
}

//Returns the number of rows in the specified grid
-(unsigned int) shinobiGrid:(ShinobiGrid *)grid numberOfRowsInSection:(int)sectionIndex {
    switch (sectionIndex) {
        case 0:
            return 1;
        case 1:
            return 4; 
        case 2:
            return 4;
        default:
            break;
    }
    return -1;
}

//Return the titles for the sections
- (NSString *)shinobiGrid:(ShinobiGrid *)grid titleForHeaderInSection:(int)section {
    switch (section) {
        case 0:
            return nil; //This section just has column titles, so doesn't need a section header
        case 1:
            return @"Risers";
        case 2:
            return @"Fallers";
        default:
            break;
    }
    
    return nil;
}

//Returns a cell for the specified coordinates on a given grid
- (SGridCell *)shinobiGrid:(ShinobiGrid *)grid cellForGridCoord:(const SGridCoord *)gridCoord {
    SGridAutoCell *cell;
    
    cell = [grid dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(cell == nil)
        cell = [[[SGridAutoCell alloc] initWithReuseIdentifier:kReuseIdentifier] autorelease];

    Stock *s;
    
    //Set up the first row with titles for the columns
    if(gridCoord.section == 0)
    {
        cell.textField.textColor = [UIColor whiteColor];
        
        switch (gridCoord.column) {
            case 0:
                cell.textField.text = @"Symbol";
                break;
            case 1:
                cell.textField.text = @"Name";
                break;
            case 2:
                cell.textField.text = @"Price";
                break;
            case 3:
                cell.textField.text = @"Change";
                break;
            case 4:
                cell.textField.text = @"% Change";
                break;
            case 5:
                cell.textField.text = @"Volume";
                break;
                
            default:
                break;
        }
        
        return cell;
    } else if (gridCoord.section == 1) {
        //Use risers data for section 1       
        s = [risers objectAtIndex:gridCoord.rowIndex];
        
        cell.textField.textColor = [UIColor blackColor];
    } else {
        //Use fallers data for section 2        
        s = [fallers objectAtIndex:gridCoord.rowIndex];
        
        cell.textField.textColor = [UIColor blackColor];
    }
    
    //Populate cell based on column
    switch (gridCoord.column) {
        case 0:
            cell.textField.text = s.symbol;
            break;
        case 1:
            cell.textField.text = s.name;
            break;
        case 2:
            cell.textField.text = [NSString stringWithFormat:@"%.2f", [s.price floatValue]];
            break;
        case 3:
            cell.textField.text = [NSString stringWithFormat:@"%.2f", [s.change floatValue]];
            break;
        case 4:
            cell.textField.text = [NSString stringWithFormat:@"%@%.2f%%", [s.changeAsPercent floatValue] > 0 ? @"+" : @"", 
                                   [s.changeAsPercent floatValue]];
            
            //Set the text color of this cell based on the change, red for -ve, green for +ve
            if ([s.changeAsPercent floatValue] > 0) 
                cell.textField.textColor = [UIColor greenColor];
            else 
                cell.textField.textColor = [UIColor redColor];
            break;
        case 5:
            cell.textField.text = [NSString stringWithFormat:@"%.0f", [s.volume floatValue]];
        default:
            break;
    }
    
    return cell;
}

-(void) dealloc {
    [risers release];
    [fallers release];
    [super dealloc];
}

@end
