/* */

/*  EngineBlock.m
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "EngineBlock.h"

#define API_FORMAT         @"json"
#define MAX_MESSAGE_LENGTH 140

@implementation EngineBlock

#pragma mark -
#pragma mark EngineBlock life cycle

- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret
{
	self = [super initWithAuthData:authData consumerKey:key consumerSecret:secret];
	if(self)
	{
		/* Do something */
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (BOOL)isAuthorizedForScreenname:(NSString *)name
{
	return [super isAuthorizedForScreenname:name];
}

- (NSString *)screenname
{
	return [self screen_name];
}

#pragma mark -
#pragma mark Twitter API Methods

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
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
	if(userId > 0)
	{
		[params setObject:[NSString stringWithFormat:@"%qu", userId] forKey:@"user_id"];
	}
	if(sinceId > 0)
	{
		[params setObject:[NSString stringWithFormat:@"%qu", sinceId] forKey:@"since_id"];
	}
	if(maxId > 0)
	{
		[params setObject:[NSString stringWithFormat:@"%qu", maxId] forKey:@"max_id"];
	}
	if(count > 0)
	{
		[params setObject:[NSString stringWithFormat:@"%d", count] forKey:@"count"];
	}
	if(page > 0)
	{
		[params setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
	}
	[params setObject:[NSString stringWithFormat:@"%d", trimUser ? 1:0] forKey:@"trim_user"];
	[params setObject:[NSString stringWithFormat:@"%d", includeRts ? 1:0] forKey:@"include_rts"];
	[params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];
	NSString *fullPath = [self queryStringWithBase:path parameters:params prefixed:YES];
	[self sendRequestWithMethod:nil path:fullPath body:nil handler:(GenericResultHandler)handler];
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
