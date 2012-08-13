/*
 *  ADEngineBlock.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

typedef void (^NSArrayResultHandler)(NSArray *result, NSError *error);
typedef void (^NSDictionaryResultHandler)(NSDictionary *result, NSError *error);

@interface ADEngineBlock : NSObject {
	
	NSString *screenname;
}

@property (nonatomic, readonly) NSString *screenname;

#pragma mark -
#pragma mark ADEngineBlock life cycle

- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret;
- (BOOL)isAuthorizedForScreenname:(NSString *)name;

@end

#pragma mark -
#pragma mark TimelineResources
@interface ADEngineBlock (TimelineResources)

#pragma mark -
#pragma mark statuses/home_timeline
- (void)homeTimelineWithHandler:(NSArrayResultHandler)handler;

- (void)homeTimelineSinceId:(unsigned long long)sinceId
                      maxId:(unsigned long long)maxId
                      count:(int)count
                       page:(int)page
                   trimUser:(BOOL)trimUser
            includeEntities:(BOOL)includeEntities
                withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/mentions
- (void)mentionsWithHandler:(NSArrayResultHandler)handler;

- (void)mentionsSinceId:(unsigned long long)sinceId
				  maxId:(unsigned long long)maxId
				  count:(int)count
				   page:(int)page
			   trimUser:(BOOL)trimUser
			 includeRts:(BOOL)includeRts
		includeEntities:(BOOL)includeEntities
			withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/public_timeline
- (void)publicTimelineWithHandler:(NSArrayResultHandler)handler;

- (void)publicTimelineTrimUser:(BOOL)trimUser
			   includeEntities:(BOOL)includeEntities
				   withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/retweeted_by_me
- (void)retweetedByMeWithHandler:(NSArrayResultHandler)handler;

- (void)retweetedByMeSinceId:(unsigned long long)sinceId
					   maxId:(unsigned long long)maxId
					   count:(int)count
						page:(int)page
					trimUser:(BOOL)trimUser
			 includeEntities:(BOOL)includeEntities
				 withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/retweeted_to_me
- (void)retweetedToMeWithHandler:(NSArrayResultHandler)handler;

- (void)retweetedToMeSinceId:(unsigned long long)sinceId
					   maxId:(unsigned long long)maxId
					   count:(int)count
						page:(int)page
					trimUser:(BOOL)trimUser
			 includeEntities:(BOOL)includeEntities
				 withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/retweets_of_me
- (void)retweetsOfMeWithHandler:(NSArrayResultHandler)handler;

- (void)retweetsOfMeSinceId:(unsigned long long)sinceId
					  maxId:(unsigned long long)maxId
					  count:(int)count
					   page:(int)page
				   trimUser:(BOOL)trimUser
			includeEntities:(BOOL)includeEntities
				withHandler:(NSArrayResultHandler)handler;

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
					  withHandler:(NSArrayResultHandler)handler;
@end

#pragma mark -
#pragma mark TweetsResources
@interface ADEngineBlock (TweetsResources)

#pragma mark -
#pragma mark statuses/show/:id
- (void)showStatus:(unsigned long long)statusId
		  trimUser:(BOOL)trimUser
   includeEntities:(BOOL)includeEntities
	   withHandler:(NSDictionaryResultHandler)handler;

#pragma mark -
#pragma mark statuses/destroy/:id
- (void)destroyStatus:(unsigned long long)statusId
			 trimUser:(BOOL)trimUser
	  includeEntities:(BOOL)includeEntities
		  withHandler:(NSDictionaryResultHandler)handler;

#pragma mark -
#pragma mark statuses/retweet/:id
- (void)retweet:(unsigned long long)statusId withHandler:(NSDictionaryResultHandler)handler;

#pragma mark -
#pragma mark statuses/update
- (void)sendUpdate:(NSString *)message withHandler:(NSDictionaryResultHandler)handler;

- (void)sendUpdate:(NSString *)message
		 inReplyTo:(unsigned long long)replyToId
		  latitude:(float)latitude
		 longitude:(float)longitude
		   placeId:(unsigned long long)placeId
	  displayCoord:(BOOL)displayCoord
		  trimUser:(BOOL)trimUser
   includeEntities:(BOOL)includeEntities
	   withHandler:(NSDictionaryResultHandler)handler;
@end

#pragma mark -
#pragma mark UserResources
@interface ADEngineBlock (UserResources)

#pragma mark -
#pragma mark users/show
- (void)showUser:(unsigned long long)userId withHandler:(NSDictionaryResultHandler)handler;

@end

#pragma mark -
#pragma mark FriendsResources
@interface ADEngineBlock (FriendsResources)

#pragma mark -
#pragma mark friends/ids
- (void)getFriendIdsWithHandler:(NSDictionaryResultHandler)handler;

@end


#pragma mark -
#pragma mark AccountResources
@interface ADEngineBlock (AccountResources)

#pragma mark -
#pragma mark account/rate_limit_status
- (void)rateLimitStatusWithHandler:(NSDictionaryResultHandler)handler;

#pragma mark -
#pragma mark account/verify_credentials
- (void)verifyCredentialsWithHandler:(NSDictionaryResultHandler)handler;

#pragma mark -
#pragma mark account/totals
- (void)totalsWithHandler:(NSDictionaryResultHandler)handler;

@end
