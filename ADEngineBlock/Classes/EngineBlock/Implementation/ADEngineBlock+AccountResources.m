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

- (void)getPath:(NSString *)path withHandler:(GenericResultHandler)handler
{
    NSURLRequest *request = [self.requestBuilder requestWithMethod:nil path:path body:nil params:nil];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

- (void)rateLimitStatusWithHandler:(NSDictionaryResultHandler)handler
{
    [self getPath:[NSString stringWithFormat:@"account/rate_limit_status.%@", API_FORMAT] withHandler:handler];
}

- (void)verifyCredentialsWithHandler:(NSDictionaryResultHandler)handler
{
    [self getPath:[NSString stringWithFormat:@"account/verify_credentials.%@", API_FORMAT] withHandler:handler];
}

- (void)totalsWithHandler:(NSDictionaryResultHandler)handler
{
    [self getPath:[NSString stringWithFormat:@"account/totals.%@", API_FORMAT] withHandler:handler];
}

@end
