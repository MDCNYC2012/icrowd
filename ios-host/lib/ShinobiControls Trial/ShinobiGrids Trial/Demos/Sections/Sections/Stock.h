//
//  Stock.h
//  DragAndDropGrid
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject 

@property (nonatomic, retain) NSString *symbol;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSNumber *change;
@property (nonatomic, retain) NSNumber *changeAsPercent;
@property (nonatomic, retain) NSNumber *volume;

-(id)initWithSymbol:(NSString *)aSymbol andName:(NSString *)aName andPrice:(NSNumber *)aPrice 
          andChange:(NSNumber *)aChange andChangePercent:(NSNumber *)aChangePercent andVolume:(NSNumber *)aVolume;

@end
