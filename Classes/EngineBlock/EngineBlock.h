/* */

/*  EngineBlock.h
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "AbstractEngineBlock.h"
#import <Foundation/Foundation.h>

typedef void (^NSArrayResultHandler)(NSArray *result, NSError *error);
typedef void (^NSDictionaryResultHandler)(NSDictionary *result, NSError *error);

@interface EngineBlock : AbstractEngineBlock {}

@property (nonatomic, readonly) NSString *screenname;

#pragma mark -
#pragma mark EngineBlock life cycle

- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret;
- (BOOL)isAuthorizedForScreenname:(NSString *)name;

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
					  withHandler:(NSArrayResultHandler)handler;

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

