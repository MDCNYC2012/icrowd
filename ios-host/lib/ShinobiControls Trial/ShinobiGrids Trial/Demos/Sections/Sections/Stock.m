//
//  Stock.m
//  DragAndDropGrid
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import "Stock.h"

@implementation Stock 
@synthesize symbol, name, price, change, changeAsPercent, volume;

-(id)initWithSymbol:(NSString *)aSymbol andName:(NSString *)aName andPrice:(NSNumber *)aPrice andChange:(NSNumber *)aChange andChangePercent:(NSNumber *)aChangePercent andVolume:(NSNumber *)aVolume{
    self = [super init];
    if (self) {
        self.symbol = aSymbol;
        self.name = aName;
        self.price = aPrice;
        self.change = aChange;
        self.changeAsPercent = aChangePercent;
        self.volume = aVolume;
    }
    return self;
}

@end
