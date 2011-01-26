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
	@private
	NSString *screenname;
	OAConsumer *consumer;
	OAToken *accessToken;
	BOOL secureConnection;
	BOOL clearsCookies;
}

@property (nonatomic, retain) NSString *screenname;

- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret;
- (BOOL)isAuthorizedForScreenname:(NSString *)name;

- (void)getTimelineForScreenname:(NSString *)name withHandler:(NSArrayResultHandler)handler;
- (void)sendUpdate:(NSString *)message withHandler:(NSDictionaryResultHandler)handler;

@end

