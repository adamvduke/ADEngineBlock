/* */

/*  EngineBlock+TimelineResources.m
 *  EngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "EngineBlock_Private.h"

@implementation EngineBlock (TimelineResources)

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
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
	[params setObject:[NSString stringWithFormat:@"%d", trimUser ? 1:0] forKey:@"trim_user"];
	[params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];
	NSString *fullPath = [self queryStringWithBase:path parameters:params prefixed:YES];
	[self sendRequestWithMethod:nil path:fullPath body:nil handler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/home_timeline
- (void)homeTimelineSinceId:(unsigned long long)sinceId
					  maxId:(unsigned long long)maxId
					  count:(int)count
					   page:(int)page
				   trimUser:(BOOL)trimUser
			includeEntities:(BOOL)includeEntities
				withHandler:(NSArrayResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/home_timeline.%@", API_FORMAT];
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
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
	[params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];
	NSString *fullPath = [self queryStringWithBase:path parameters:params prefixed:YES];
	[self sendRequestWithMethod:nil path:fullPath body:nil handler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/friends_timeline
- (void)friendsTimelineSinceId:(unsigned long long)sinceId
						 maxId:(unsigned long long)maxId
						 count:(int)count
						  page:(int)page
					  trimUser:(BOOL)trimUser
					includeRts:(BOOL)includeRts
			   includeEntities:(BOOL)includeEntities
				   withHandler:(NSArrayResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/friends_timeline.%@", API_FORMAT];
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
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

#pragma mark -
#pragma mark statuses/mentions
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
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
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

#pragma mark -
#pragma mark statuses/retweeted_by_me
- (void)retweetedByMeSinceId:(unsigned long long)sinceId
					   maxId:(unsigned long long)maxId
					   count:(int)count
						page:(int)page
					trimUser:(BOOL)trimUser
			 includeEntities:(BOOL)includeEntities
				 withHandler:(NSArrayResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/retweeted_by_me.%@", API_FORMAT];
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
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
	[params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];
	NSString *fullPath = [self queryStringWithBase:path parameters:params prefixed:YES];
	[self sendRequestWithMethod:nil path:fullPath body:nil handler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/retweeted_to_me
- (void)retweetedToMeSinceId:(unsigned long long)sinceId
					   maxId:(unsigned long long)maxId
					   count:(int)count
						page:(int)page
					trimUser:(BOOL)trimUser
			 includeEntities:(BOOL)includeEntities
				 withHandler:(NSArrayResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/retweeted_to_me.%@", API_FORMAT];
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
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
	[params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];
	NSString *fullPath = [self queryStringWithBase:path parameters:params prefixed:YES];
	[self sendRequestWithMethod:nil path:fullPath body:nil handler:(GenericResultHandler)handler];
}

#pragma mark -
#pragma mark statuses/retweets_of_me
- (void)retweetsOfMeSinceId:(unsigned long long)sinceId
					  maxId:(unsigned long long)maxId
					  count:(int)count
					   page:(int)page
				   trimUser:(BOOL)trimUser
			includeEntities:(BOOL)includeEntities
				withHandler:(NSArrayResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/retweets_of_me.%@", API_FORMAT];
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
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
	[params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];
	NSString *fullPath = [self queryStringWithBase:path parameters:params prefixed:YES];
	[self sendRequestWithMethod:nil path:fullPath body:nil handler:(GenericResultHandler)handler];
}
@end
