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
@synthesize sortedGrains=_sortedGrains;

-(NSArray *)sortedGrains
{
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    return [self.grain sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
}

@end
