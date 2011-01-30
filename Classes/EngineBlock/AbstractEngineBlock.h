/* */

/*  AbstractEngineBlock.h
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/29/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@class OAConsumer;
@class OAMutableURLRequest;
@class OAToken;

typedef void (^GenericResultHandler)(id result, NSError *error);

@interface AbstractEngineBlock : NSObject {
	@protected
	NSString *screen_name;
	OAConsumer *consumer;
	OAToken *accessToken;
	BOOL secureConnection;
	BOOL clearsCookies;
}

@property (nonatomic, retain) NSString *screen_name;

#pragma mark -
#pragma mark pre-defined blocks
- ( void (^)(id data, NSHTTPURLResponse *response, NSError *error) )jsonHandlerWithEngineHandler:(GenericResultHandler)handler;

/* returns a block that tests a "tuple" e.g.(screen_name=adamvduke)
 * and checks to see if the element to the left of the = sign
 * is equivalent to the given key
 */
- ( BOOL (^)(id obj, NSUInteger idx, BOOL *stop) )blockTestTupleForKey:(NSString *)aKey;

#pragma mark -
#pragma mark AbstractEngineBlock life cycle
- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret;
- (void)setAccessTokenWithAuthData:(NSString *)authData;
- (void)setConsumerWithKey:(NSString *)key secret:(NSString *)secret;

#pragma mark -
#pragma mark Helper methods
- (NSString *)screennameFromAuthData:(NSString *)authData;
- (NSString *)valueForKey:(NSString *)aKey inAuthData:(NSString *)authData;
- (BOOL)hasValidAccessToken:(OAToken *)token;
- (BOOL)isAuthorizedForScreenname:(NSString *)name;

#pragma mark -
#pragma mark NSURLRequest helper methods
- (OAMutableURLRequest *)requestWithURL:(NSURL *)url;
- (NSString *)urlStringWithPath:(NSString *)path;
- (NSString *)encodeString:(NSString *)string;
- (NSString *)queryStringWithBase:(NSString *)base parameters:(NSDictionary *)params prefixed:(BOOL)prefixed;
- (void)setClientHeadersForRequest:(NSMutableURLRequest *)theRequest;
- (void)setRequest:(NSMutableURLRequest *)request body:(NSString *)body forMethod:(NSString *)method;

#pragma mark -
#pragma mark Send Request
- (void)sendRequestWithMethod:(NSString *)method path:(NSString *)path body:(NSString *)body handler:(GenericResultHandler)handler;
@end
