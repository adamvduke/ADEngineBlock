/* */

/*  EngineBlock+TweetsResources.m
 *  EngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "EngineBlock_Private.h"

@implementation EngineBlock (TweetsResources)

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

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
	[params setObject:trimmedText forKey:@"status"];
	if(replyToId > 0)
	{
		[params setObject:[NSString stringWithFormat:@"%qu", replyToId] forKey:@"in_reply_to_status_id"];
	}
	if(-90.0f <= latitude <= 90.0f)
	{
		[params setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"lat"];
	}
	if(-180.0f <= longitude <= 180.0f)
	{
		[params setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"long"];
	}
	if(placeId > 0)
	{
		[params setObject:[NSString stringWithFormat:@"%qu", placeId] forKey:@"place_id"];
	}
	[params setObject:[NSString stringWithFormat:@"%d", displayCoord ? 1:0] forKey:@"display_coordinates"];
	[params setObject:[NSString stringWithFormat:@"%d", trimUser ? 1:0] forKey:@"trim_user"];
	[params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];

	NSString *body = [self queryStringWithBase:nil parameters:params prefixed:NO];
	[self sendRequestWithMethod:@"POST" path:path body:body handler:(GenericResultHandler)handler];
}

@end
