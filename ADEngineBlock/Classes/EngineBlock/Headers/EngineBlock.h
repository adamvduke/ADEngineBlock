/* */

/*  EngineBlock.h
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@class OAToken;
@class OAConsumer;

typedef void (^NSArrayResultHandler)(NSArray *result, NSError *error);
typedef void (^NSDictionaryResultHandler)(NSDictionary *result, NSError *error);

@interface EngineBlock : NSObject {
	
	NSString *screenname;

@private
	OAConsumer *consumer;
	OAToken *accessToken;
}

@property (nonatomic, readonly) NSString *screenname;

#pragma mark -
#pragma mark EngineBlock life cycle

- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret;
- (BOOL)isAuthorizedForScreenname:(NSString *)name;

@end


#pragma mark -
#pragma mark TimelineResources
@interface EngineBlock (TimelineResources)

#pragma mark -
#pragma mark statuses/public_timeline
- (void)publicTimelineWithHandler:(NSArrayResultHandler)handler;

- (void)publicTimelineTrimUser:(BOOL)trimUser
			   includeEntities:(BOOL)includeEntities
				   withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/home_timeline
- (void)homeTimelineSinceId:(unsigned long long)sinceId
						 maxId:(unsigned long long)maxId
						 count:(int)count
						  page:(int)page
					  trimUser:(BOOL)trimUser
			   includeEntities:(BOOL)includeEntities
				   withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/friends_timeline
- (void)friendsTimelineSinceId:(unsigned long long)sinceId
						 maxId:(unsigned long long)maxId
						 count:(int)count
						  page:(int)page
					  trimUser:(BOOL)trimUser
					includeRts:(BOOL)includeRts
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

#pragma mark -
#pragma mark statuses/mentions
- (void)mentionsSinceId:(unsigned long long)sinceId
				  maxId:(unsigned long long)maxId
				  count:(int)count
				   page:(int)page
			   trimUser:(BOOL)trimUser
			 includeRts:(BOOL)includeRts
		includeEntities:(BOOL)includeEntities
			withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/retweeted_by_me
- (void)retweetedByMeSinceId:(unsigned long long)sinceId
					   maxId:(unsigned long long)maxId
					   count:(int)count
						page:(int)page
					trimUser:(BOOL)trimUser
			 includeEntities:(BOOL)includeEntities
				 withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/retweeted_to_me
- (void)retweetedToMeSinceId:(unsigned long long)sinceId
					   maxId:(unsigned long long)maxId
					   count:(int)count
						page:(int)page
					trimUser:(BOOL)trimUser
			 includeEntities:(BOOL)includeEntities
				 withHandler:(NSArrayResultHandler)handler;

#pragma mark -
#pragma mark statuses/retweets_of_me
- (void)retweetsOfMeSinceId:(unsigned long long)sinceId
					  maxId:(unsigned long long)maxId
					  count:(int)count
					   page:(int)page
				   trimUser:(BOOL)trimUser
			includeEntities:(BOOL)includeEntities
				withHandler:(NSArrayResultHandler)handler;
@end

#pragma mark -
#pragma mark TweetsResources
@interface EngineBlock (TweetsResources)

#pragma mark -
#pragma mark statuses/show/:id
- (void)showStatus:(unsigned long long)statusId
		  trimUser:(BOOL)trimUser
   includeEntities:(BOOL)includeEntities
	   withHandler:(NSDictionaryResultHandler)handler;

#pragma mark -
#pragma mark statuses/update
- (void)sendUpdate:(NSString *)message
		 inReplyTo:(unsigned long long)replyToId
		  latitude:(float)latitude
		 longitude:(float)longitude
		   placeId:(unsigned long long)placeId
	  displayCoord:(BOOL)displayCoord
		  trimUser:(BOOL)trimUser
   includeEntities:(BOOL)includeEntities
	   withHandler:(NSDictionaryResultHandler)handler;

#pragma mark -
#pragma mark statuses/destroy/:id
- (void)destroyStatus:(unsigned long long)statusId
			 trimUser:(BOOL)trimUser
	  includeEntities:(BOOL)includeEntities
		  withHandler:(NSDictionaryResultHandler)handler;
@end
