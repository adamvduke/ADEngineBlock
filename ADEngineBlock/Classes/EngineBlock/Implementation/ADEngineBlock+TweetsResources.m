/*
 *  ADEngineBlock+TweetsResources.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock_Private.h"
#import "ADEngineBlockParameterBuilder.h"
#import "ADEngineBlockRequestBuilder.h"

@implementation ADEngineBlock (TweetsResources)

#pragma mark -
#pragma mark statuses/show/:id
- (void)showStatus:(unsigned long long)statusId
          trimUser:(BOOL)trimUser
   includeEntities:(BOOL)includeEntities
       withHandler:(NSDictionaryResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/show/%qu.%@", statusId, API_FORMAT];
    NSDictionary *params = [ADEngineBlockParameterBuilder trimUser:trimUser includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:nil path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/destroy/:id
- (void)destroyStatus:(unsigned long long)statusId
             trimUser:(BOOL)trimUser
      includeEntities:(BOOL)includeEntities
          withHandler:(NSDictionaryResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/destroy/%qu.%@", statusId, API_FORMAT];
    NSDictionary *params = [ADEngineBlockParameterBuilder trimUser:trimUser includeEntities:includeEntities];
    NSURLRequest *request = [requestBuilder requestWithMethod:@"POST" path:path body:nil params:params];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/retweet/:id
- (void)retweet:(unsigned long long)statusId withHandler:(NSDictionaryResultHandler)handler
{
    NSString *path = [NSString stringWithFormat:@"statuses/retweet/%qu.%@", statusId, API_FORMAT];
    NSURLRequest *request = [requestBuilder requestWithMethod:@"POST" path:path body:nil params:nil];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/update
- (void)sendUpdate:(NSString *)message withHandler:(NSDictionaryResultHandler)handler
{
    [self sendUpdate:message inReplyTo:0 latitude:FLT_MIN longitude:FLT_MIN placeId:0 displayCoord:NO trimUser:NO includeEntities:YES withHandler:handler];
}

- (void)sendUpdate:(NSString *)message
         inReplyTo:(unsigned long long)replyToId
          latitude:(float)latitude
         longitude:(float)longitude
           placeId:(unsigned long long)placeId
      displayCoord:(BOOL)displayCoord
          trimUser:(BOOL)trimUser
   includeEntities:(BOOL)includeEntities
       withHandler:(NSDictionaryResultHandler)handler
{
    if(!message)
    {
        return;
    }
    NSString *path = [NSString stringWithFormat:@"statuses/update.%@", API_FORMAT];
    NSString *trimmedText = message;
    if([trimmedText length] > MAX_MESSAGE_LENGTH)
    {
        trimmedText = [trimmedText substringToIndex:MAX_MESSAGE_LENGTH];
    }

    NSDictionary *params = [ADEngineBlockParameterBuilder update:trimmedText inReplyTo:replyToId latitude:latitude longitude:longitude placeId:placeId displayCoord:displayCoord trimUser:trimUser includeEntities:includeEntities];
    NSString *body = [requestBuilder queryStringWithBase:nil parameters:params prefixed:NO];
    NSURLRequest *request = [requestBuilder requestWithMethod:@"POST" path:path body:body params:nil];
    [self sendRequest:request withHandler:(GenericResultHandler)handler];
}
@end
