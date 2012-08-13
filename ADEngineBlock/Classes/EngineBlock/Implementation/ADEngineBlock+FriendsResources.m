//
//  ADEngineBlock+FriendsResources.m
//  Pods
//
//  Created by Adam Duke on 8/12/12.
//
//

#import "ADEngineBlock_Private.h"
#import "ADEngineBlockParameterBuilder.h"
#import "ADEngineBlockRequestBuilder.h"

@implementation ADEngineBlock (FriendsResources)

- (void)getFriendIdsWithHandler:(NSDictionaryResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"friends/ids.%@", API_FORMAT];
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"-1" forKey:@"cursor"];
    NSURLRequest *request = [self.requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)[[handler copy] autorelease]];
}

@end
