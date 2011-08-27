/*
 *  ADEngineBlock+TimelineResources.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock.h"
#import "ADEngineBlock_Private.h"
#import "ADEngineBlockParameterBuilder.h"
#import "ADEngineBlockRequestBuilder.h"

@implementation ADEngineBlock (TimelineResources)

#pragma mark -
#pragma mark statuses/home_timeline
- (void)homeTimelineWithHandler:(NSArrayResultHandler)handler
{
    [self homeTimelineSinceId:0 maxId:0 count:0 page:0 trimUser:NO includeEntities:YES withHandler:handler];
}

- (void)homeTimelineSinceId:(unsigned long long)sinceId
                      maxId:(unsigned long long)maxId
                      count:(int)count
                       page:(int)page
                   trimUser:(BOOL)trimUser
            includeEntities:(BOOL)includeEntities
                withHandler:(NSArrayResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/home_timeline.%@", API_FORMAT];
    NSDictionary *params = [parameterBuilder sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/mentions
- (void)mentionsWithHandler:(NSArrayResultHandler)handler
{
    [self mentionsSinceId:0 maxId:0 count:0 page:0 trimUser:NO includeRts:YES includeEntities:YES withHandler:handler];
}

- (void)mentionsSinceId:(unsigned long long)sinceId
                  maxId:(unsigned long long)maxId
                  count:(int)count
                   page:(int)page
               trimUser:(BOOL)trimUser
             includeRts:(BOOL)includeRts
        includeEntities:(BOOL)includeEntities
            withHandler:(NSArrayResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/mentions.%@", API_FORMAT];
    NSDictionary *params = [parameterBuilder sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeRts:includeRts includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/public_timeline
- (void)publicTimelineWithHandler:(NSArrayResultHandler)handler
{
    [self publicTimelineTrimUser:NO includeEntities:YES withHandler:handler];
}

- (void)publicTimelineTrimUser:(BOOL)trimUser
               includeEntities:(BOOL)includeEntities
                   withHandler:(NSArrayResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/public_timeline.%@", API_FORMAT];
    NSDictionary *params = [parameterBuilder trimUser:trimUser includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/retweeted_by_me
- (void)retweetedByMeWithHandler:(NSArrayResultHandler)handler
{
    [self retweetedByMeSinceId:0 maxId:0 count:0 page:0 trimUser:NO includeEntities:YES withHandler:handler];
}

- (void)retweetedByMeSinceId:(unsigned long long)sinceId
                       maxId:(unsigned long long)maxId
                       count:(int)count
                        page:(int)page
                    trimUser:(BOOL)trimUser
             includeEntities:(BOOL)includeEntities
                 withHandler:(NSArrayResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/retweeted_by_me.%@", API_FORMAT];
    NSDictionary *params = [parameterBuilder sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/retweeted_to_me
- (void)retweetedToMeWithHandler:(NSArrayResultHandler)handler
{
    [self retweetedToMeSinceId:0 maxId:0 count:0 page:0 trimUser:NO includeEntities:YES withHandler:handler];
}

- (void)retweetedToMeSinceId:(unsigned long long)sinceId
                       maxId:(unsigned long long)maxId
                       count:(int)count
                        page:(int)page
                    trimUser:(BOOL)trimUser
             includeEntities:(BOOL)includeEntities
                 withHandler:(NSArrayResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/retweeted_to_me.%@", API_FORMAT];
    NSDictionary *params = [parameterBuilder sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/retweets_of_me
- (void)retweetsOfMeWithHandler:(NSArrayResultHandler)handler
{
    [self retweetsOfMeSinceId:0 maxId:0 count:0 page:0 trimUser:NO includeEntities:YES withHandler:handler];
}

- (void)retweetsOfMeSinceId:(unsigned long long)sinceId
                      maxId:(unsigned long long)maxId
                      count:(int)count
                       page:(int)page
                   trimUser:(BOOL)trimUser
            includeEntities:(BOOL)includeEntities
                withHandler:(NSArrayResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/retweets_of_me.%@", API_FORMAT];
    NSDictionary *params = [parameterBuilder sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/user_timeline
- (void)userTimelineForScreenname:(NSString *)name
                           userId:(unsigned long long)userId
                          sinceId:(unsigned long long)sinceId
                            maxId:(unsigned long long)maxId
                            count:(int)count
                             page:(int)page
                         trimUser:(BOOL)trimUser
                       includeRts:(BOOL)includeRts
                  includeEntities:(BOOL)includeEntities
                      withHandler:(NSArrayResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/user_timeline/%@.%@", name, API_FORMAT];
    NSDictionary *params = [parameterBuilder userId:userId sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeRts:includeRts includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

@end
