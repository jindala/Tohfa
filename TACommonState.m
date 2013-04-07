//
//  TACommonState.m
//  Tohfa
//
//  Created by Anupam Jindal on 4/7/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import "TACommonState.h"

@implementation TACommonState

@synthesize orderProducts = _orderProducts;

static TACommonState *sharedObj = nil;

-(id) init {
    self = [super init];
    if(self) {
        self.orderProducts = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+(TACommonState *)sharedObj {
    @synchronized(self) {
		if (sharedObj == nil) {
			sharedObj = [[TACommonState alloc] init];
			// assignment not done here
		}
	}
	return sharedObj;
}

@end
