/*
 *  ADEngineBlock+RequestHandling.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 1/29/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock_Private.h"
#import "OAMutableURLRequest.h"
#import "SBJson.h"
#import "Seriously.h"
#import <objc/runtime.h>

// this key is used along with the requestBuilder property
// to dynamically create an "ivar" within the RequestHandling
// category using objc_setAssociatedObject
const char *requestBuilderKey = "requestBuilderKey";

@implementation ADEngineBlock (RequestHandling)

#pragma mark -
#pragma mark ADEngineBlockRequestBuilder property magic
@dynamic requestBuilder;

// The following two methods the getter/setter implementations for the requestBuilder property
// they use objc_setAssociatedObject and objc_getAssociatedObject, along with the requestBuilderKey
// to retain or retrieve the passed in ADEngineBlockRequestBuilder. This pattern effectively
// creates an instance variable within the RequestHandling category.
- (void)setRequestBuilder:(ADEngineBlockRequestBuilder *)requestBuilder
{
    objc_setAssociatedObject(self, requestBuilderKey, requestBuilder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ADEngineBlockRequestBuilder *)requestBuilder
{
    return objc_getAssociatedObject(self, requestBuilderKey);
}

#pragma mark -
#pragma mark pre-defined blocks
- ( void (^)(id data, NSHTTPURLResponse *response, NSError *error) )jsonHandlerWithEngineHandler:(GenericResultHandler)handler;
{
    return [[^(id data, NSHTTPURLResponse *response, NSError *error)
             {
                 if(error)
                 {
                     handler (nil, error);
                     return;
                 }
                 NSString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
                 id jsonValue = [jsonString JSONValue];
                 handler (jsonValue, nil);
             } copy] autorelease];
}

#pragma mark -
#pragma mark Send Request
- (void)sendRequest:(NSURLRequest *)request withHandler:(GenericResultHandler)handler
{
    [Seriously oauthRequest:request options:nil handler:[self jsonHandlerWithEngineHandler:handler]];
}

@end
