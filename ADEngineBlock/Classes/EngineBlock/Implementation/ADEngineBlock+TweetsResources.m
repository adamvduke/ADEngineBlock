/*  
 *  ADEngineBlock+TweetsResources.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock_Private.h"

@implementation ADEngineBlock (TweetsResources)

- (void)    sendUpdate:(NSString *)message
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
	NSString *path = [NSString stringWithFormat:@"statuses/update.%@", API_FORMAT, replyToId];
	NSString *trimmedText = message;
	if([trimmedText length] > MAX_MESSAGE_LENGTH)
	{
		trimmedText = [trimmedText substringToIndex:MAX_MESSAGE_LENGTH];
	}
    
	NSDictionary *params = [parameterBuilder update:message inReplyTo:replyToId latitude:latitude longitude:longitude placeId:placeId displayCoord:displayCoord trimUser:trimUser includeEntities:includeEntities];
	NSString *body = [requestBuilder queryStringWithBase:nil parameters:params prefixed:NO];    
    NSURLRequest *request = [requestBuilder requestWithMethod:@"POST" path:path body:body params:nil];
	[self sendRequest:request withHandler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/show/:id
- (void)showStatus:(unsigned long long)statusId
		  trimUser:(BOOL)trimUser
   includeEntities:(BOOL)includeEntities
	   withHandler:(NSDictionaryResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/show/%qu.%@",statusId, API_FORMAT];
    NSDictionary *params = [parameterBuilder trimUser:trimUser includeEntities:includeEntities];
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
	NSString *path = [NSString stringWithFormat:@"statuses/destroy/%qu.%@",statusId, API_FORMAT];
    NSDictionary *params = [parameterBuilder trimUser:trimUser includeEntities:includeEntities];
	NSURLRequest *request = [requestBuilder requestWithMethod:@"POST" path:path body:nil params:params];
	[self sendRequest:request withHandler:(GenericResultHandler)handler];
}
@end