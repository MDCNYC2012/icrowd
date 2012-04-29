//
//  GridDataSource.m
//  SimpleGrid
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import "DataSource.h"

@interface Country : NSObject 
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *population;
@end

@implementation Country
@synthesize name, population;
-(id) initWithName:(NSString *)countryName andPopulation:(NSString *)pop {
    self = [super init];
    if (self) {
        self.name = countryName;
        self.population = pop;
    }
    return self;
}
@end

NSString *const kReuseIdentifier = @"MyCell";

@implementation DataSource 

-(id)init
{
    self = [super init];
    if(self) {
        struct
        {
            NSString *name;
            NSString *population;
        } countryData[] = {
            { @"China"                            , @"1,339,724,852" },
            { @"India"                            , @"1,210,193,422" },
            { @"United States"                    , @"312,972,000"   },
            { @"Indonesia"                        , @"237,641,326"   },
            { @"Brazil"                           , @"192,376,496"   },
            { @"Pakistan"                         , @"178,627,000"   },
            { @"Nigeria"                          , @"162,471,000"   },
            { @"Russia"                           , @"143,030,106"   },
            { @"Bangladesh"                       , @"142,319,000"   },
            { @"Japan"                            , @"127,730,000"   },
            { @"Mexico"                           , @"112,336,538"   },
            { @"Philippines"                      , @"94,013,200"    },
            { @"Vietnam"                          , @"87,840,000"    },
            { @"Ethiopia"                         , @"84,320,987"    },
            { @"Germany"                          , @"81,768,000"    },
            { @"Egypt"                            , @"81,507,000"    },
            { @"Iran"                             , @"76,073,000"    },
            { @"Turkey"                           , @"74,724,269"    },
            { @"Democratic Republic of the Congo" , @"67,758,000"    },
            { @"Thailand"                         , @"65,926,261"    },
            { @"France"                           , @"65,350,000"    },
            { @"United Kingdom"                   , @"62,300,000"    },
            { @"Italy"                            , @"60,757,278"    },
            { @"South Africa"                     , @"50,586,757"    },
            { @"South Korea"                      , @"48,580,000"    },
            { nil                                 , nil              },
        };

        countries = [[NSMutableArray alloc] init];

        for(int i = 0; countryData[i].name; i++){
            Country *newCountry = [[Country alloc]
                initWithName:countryData[i].name
               andPopulation:countryData[i].population];

            [countries addObject:[newCountry autorelease]];
        }
    }
    return self;
}

- (SGridCell *)shinobiGrid:(ShinobiGrid *)grid cellForGridCoord:(const SGridCoord *) gridCoord{
    SGridAutoCell *cell;
    
    cell = [grid dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(cell == nil)
        cell = [[[SGridAutoCell alloc] initWithReuseIdentifier:kReuseIdentifier] autorelease];
    
    //Populate the first row with title for each column, and apply the header style
    if(gridCoord.row.index == 0)
    {
        cell.clipsToBounds = YES;
        
        UIImageView *iv = [[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
        [iv setImage:[UIImage imageNamed:@"gradient.png"]];
        [cell addSubview:iv];
        
        UILabel *headerLabel = [[[UILabel alloc] initWithFrame:cell.bounds] autorelease];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.textAlignment = UITextAlignmentCenter;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            headerLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:35.f];
        } else {
            headerLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:20.f];
        }
        
        if (gridCoord.column == 0) {
            headerLabel.text = @"Country";
        } else {
            headerLabel.text = @"Population";
        }
        [cell addSubview:headerLabel];
    }
    else {
        if (gridCoord.column == 0) {
            cell.textField.text = ((Country *)[countries objectAtIndex:gridCoord.row.index - 1]).name;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                cell.textField.font = [UIFont fontWithName:@"AmericanTypewriter" size:22.0f];
            } else {
                cell.textField.font = [UIFont fontWithName:@"AmericanTypewriter" size:13.0f];
            }
            
            cell.textField.textColor = [UIColor whiteColor];
        } else {
            cell.textField.text = ((Country *)[countries objectAtIndex:gridCoord.row.index - 1]).population;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                cell.textField.font = [UIFont fontWithName:@"ArialHebrew" size:25.0f];                
            } else {
                cell.textField.font = [UIFont fontWithName:@"ArialHebrew" size:17.0f];                
            }
            
             cell.textField.textColor = [UIColor whiteColor];
        }
       
        
    }
    
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

- (unsigned int)shinobiGrid:(ShinobiGrid *) grid numberOfRowsInSection:(int) sectionIndex {
    return 14; 
}

- (unsigned int)numberOfColsForShinobiGrid:(ShinobiGrid *)grid{
    return 2;
}

-(void) dealloc {
    [countries release];
    [super dealloc];
}

@end
