/*  
 *  ADEngineBlock_Private.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock.h"

@class ADEngineBlockRequestBuilder;

#define API_FORMAT         @"json"
#define MAX_MESSAGE_LENGTH 140

typedef void (^GenericResultHandler)(id result, NSError *error);

// this key is used along with the requestBuilder property
// to dynamically create an "ivar" within the RequestHandling
// category using objc_setAssociatedObject
extern const char *requestBuilderKey;

@interface ADEngineBlock (RequestHandling) 

@property(nonatomic,retain)ADEngineBlockRequestBuilder *requestBuilder;

- (void)sendRequest:(NSURLRequest*)request withHandler:(GenericResultHandler)handler;

@end
