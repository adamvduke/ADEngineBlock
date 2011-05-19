/*  
 *  ADEngineBlock_Private.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock.h"

#define API_FORMAT         @"json"
#define MAX_MESSAGE_LENGTH 140

typedef void (^GenericResultHandler)(id result, NSError *error);

@interface ADEngineBlock (RequestHandling) 

- (void)sendRequest:(NSURLRequest*)request withHandler:(GenericResultHandler)handler;

@end