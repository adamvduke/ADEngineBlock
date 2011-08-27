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

@implementation ADEngineBlock (RequestHandling)

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
