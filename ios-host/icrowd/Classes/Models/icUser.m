//
//  icUser.m
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "icUser.h"
#import "icGrain.h"


@implementation icUser

@dynamic age;
@dynamic gender;
@dynamic idx;
@dynamic name;
@dynamic grain;
@synthesize grainSorted=_grainSorted;
@synthesize grainMostRecent=_grainMostRecent;

-(NSArray *)sortedGrains
{
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    return [self.grain sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
}

-(icGrain *)grainMostRecent
{
    if (!self.hasGrain)
        return nil;
    return [self.grainSorted objectAtIndex:([self.grainSorted count]-1)];
}

- (BOOL)hasGrain
{
    return [self.grain count]>=1;
}

@end
