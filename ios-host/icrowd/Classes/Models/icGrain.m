//
//  icGrain.m
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "icGrain.h"
#import "icSession.h"
#import "icUser.h"


@implementation icGrain

@dynamic date;
@dynamic feeling;
@dynamic idx;
@dynamic intensity;
@dynamic session;
@dynamic user;

-(BOOL)occurredWithinSeconds:(int)s
{
    NSDate * xDate = [NSDate dateWithTimeInterval:0 sinceDate:self.date];
    omLogDev( @"%f < %i = %@", ABS([xDate timeIntervalSinceNow]), s, (ABS([xDate timeIntervalSinceNow]) < s) ?@"YES":@"NO");
    return ABS([xDate timeIntervalSinceNow]) < s;
}

@end
