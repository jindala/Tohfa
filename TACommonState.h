//
//  TACommonState.h
//  Tohfa
//
//  Created by Anupam Jindal on 4/7/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TACommonState : NSObject

@property (nonatomic, strong) NSMutableArray *orderProducts;

+(TACommonState *)sharedObj;
@end
