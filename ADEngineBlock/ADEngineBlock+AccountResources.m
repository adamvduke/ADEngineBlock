//
//  ADEngineBlock+AccountResources.m
//  ADEngineBlock
//
//  Created by Adam Duke on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ADEngineBlock_Private.h"
#import "ADEngineBlockRequestBuilder.h"

@implementation ADEngineBlock (AccountResources)

- (void)rateLimitStatusWithHandler:(NSDictionaryResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"account/rate_limit_status.%@", API_FORMAT];
    NSURLRequest *request = [self.requestBuilder requestWithMethod:nil path:path body:nil params:nil];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

- (void)verifyCredentialsWithHandler:(NSDictionaryResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"account/verify_credentials.%@", API_FORMAT];
    NSURLRequest *request = [self.requestBuilder requestWithMethod:nil path:path body:nil params:nil];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

@end
