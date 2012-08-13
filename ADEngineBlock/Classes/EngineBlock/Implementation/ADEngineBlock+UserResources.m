//
//  NSObject+ADEngineBlock_UserResources.m
//  Pods
//
//  Created by Adam Duke on 8/12/12.
//
//

#import "ADEngineBlock_Private.h"
#import "ADEngineBlockParameterBuilder.h"
#import "ADEngineBlockRequestBuilder.h"

@implementation ADEngineBlock (UserResources)

- (void)showUser:(unsigned long long)userId withHandler:(NSDictionaryResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"users/show/%qu.%@", userId, API_FORMAT];
    NSDictionary *params = [ADEngineBlockParameterBuilder userId:userId sinceId:0 maxId:0 count:0 page:0 trimUser:NO includeRts:NO includeEntities:YES];
    NSURLRequest *request = [self.requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)[[handler copy] autorelease]];
}

@end
