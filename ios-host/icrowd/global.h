//
//  global.h
//  ontimeTests_alpha_global
//
//  Created by Nick Kaye on 4/21/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "constants.h"

#ifndef ic_global_h
#define ic_global_h

#ifdef DEBUG
#define omLogDev(...) printf("%s [Line %d] %s\n",__PRETTY_FUNCTION__, __LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define omLogDev(...) do{}while(0)
#endif

typedef enum {
    female = 1,
    male
} gender;

#endif
