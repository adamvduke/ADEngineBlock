/* */

/*  EngineBlock.m
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "EngineBlock.h"
#import "NSString+CaseInsensitiveCompare.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OAToken.h"
#import "Seriously.h"
#import <JSON/JSON.h>

#define API_FORMAT              @"json"
#define TWITTER_DOMAIN          @"api.twitter.com"
#define TWITTER_SEARCH_DOMAIN   @"search.twitter.com"
#define HTTP_POST_METHOD        @"POST"

#define DEFAULT_CLIENT_NAME     @"EngineBlock"
#define DEFAULT_CLIENT_VERSION  @"0.1"
#define DEFAULT_CLIENT_URL      @"http://github.com/adamvduke"
#define DEFAULT_CLIENT_TOKEN    @"adtwitterengine"

typedef void (^GenericResultHandler)(id result, NSError *error);

@interface EngineBlock (Private)

- (BOOL)hasValidAccessToken:(OAToken *)token;
- (void)setAccessTokenWithAuthData:(NSString *)authData;
- (void)setConsumerWithKey:(NSString *)key secret:(NSString *)secret;
- (void)setClientHeadersForRequest:(NSMutableURLRequest *)theRequest;
- (NSString *)valueForKey:(NSString *)aKey inAuthData:(NSString *)authData;
- (NSString *)screennameFromAuthData:(NSString *)authData;
- (NSString *)urlStringWithPath:(NSString *)path;
- (NSString *)encodeString:(NSString *)string;
- (OAMutableURLRequest *)requestWithURL:(NSURL *)url;

/* returns a block that tests a "tuple" e.g.(screen_name=adamvduke)
 * and checks to see if the element to the left of the = sign
 * is equivalent to the given key
 */
- ( BOOL (^)(id obj, NSUInteger idx, BOOL *stop) )blockTestTupleForKey:(NSString *)aKey;

/* returns a block that will call the given block with a parsed json object */
- (SeriouslyHandler)jsonHandlerWithEngineHandler:(GenericResultHandler)handler;

@end

@implementation EngineBlock

@synthesize screenname;

#pragma mark -
#pragma mark pre-defined blocks

- (SeriouslyHandler)jsonHandlerWithEngineHandler:(GenericResultHandler)handler
{
	return [[^(id data, NSHTTPURLResponse *response, NSError *error)
	         {
				 if(error)
				 {
					 handler (nil, error);
					 return;
				 }
				 NSString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
				 id jsonValue = [jsonString JSONValue];
				 handler (jsonValue, nil);
			 } copy] autorelease];
}

- ( BOOL (^)(id obj, NSUInteger idx, BOOL *stop) )blockTestTupleForKey:(NSString *)aKey
{
	/* block magic :-) */
	return [[^(id obj, NSUInteger idx, BOOL *stop)
	         {
				 NSString *pair = (NSString *)obj;
				 NSArray *elements = [pair componentsSeparatedByString:@"="];
				 if([[elements objectAtIndex:0] isEqualToString:aKey])
				 {
					 *stop = YES;
					 return YES;
				 }
				 return NO;
			 } copy] autorelease];
}

#pragma mark -
#pragma mark EngineBlock life cycle
- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret
{
	if( IsEmpty(authData) || IsEmpty(key) || IsEmpty(secret) )
	{
		[NSException raise:@"EBInvalidArgumentException" format:@"The values for authData, consumerKey, and consumerSecret must not be null or empty."];
	}
	self = [super init];
	if(self)
	{
		[self setAccessTokenWithAuthData:authData];
		[self setConsumerWithKey:key secret:secret];
		secureConnection = YES;
		clearsCookies = NO;
	}
	return self;
}

- (void)setAccessTokenWithAuthData:(NSString *)authData
{
	TT_RELEASE_SAFELY(accessToken);
	if( !IsEmpty(authData) )
	{
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:authData];
		self.screenname = [self screennameFromAuthData:authData];
	}
}

- (void)setConsumerWithKey:(NSString *)key secret:(NSString *)secret
{
	consumer = [[OAConsumer alloc] initWithKey:key secret:secret];
}

- (NSString *)valueForKey:(NSString *)aKey inAuthData:(NSString *)authData
{
	NSArray *pairs = [authData componentsSeparatedByString:@"&"];
	NSUInteger index = [pairs indexOfObjectPassingTest:[self blockTestTupleForKey:aKey]];
	if(pairs == nil || index == NSNotFound)
	{
		return nil;
	}
	NSString *pair = [pairs objectAtIndex:index];
	NSArray *elements = [pair componentsSeparatedByString:@"="];
	return [elements objectAtIndex:1];
}

- (NSString *)screennameFromAuthData:(NSString *)authData
{
	NSString *name = [self valueForKey:@"screen_name" inAuthData:authData];
	return name;
}

- (BOOL)hasValidAccessToken:(OAToken *)token
{
	if(token == nil)
	{
		return NO;
	}
	return !IsEmpty(token.key) && !IsEmpty(token.secret);
}

- (BOOL)isAuthorizedForScreenname:(NSString *)name
{
	if([name isEqualIgnoreCase:self.screenname])
	{
		return [self hasValidAccessToken:accessToken];
	}
	return NO;
}

- (void)dealloc
{
	TT_RELEASE_SAFELY(screenname);
	TT_RELEASE_SAFELY(accessToken);
	TT_RELEASE_SAFELY(consumer);
	[super dealloc];
}

- (void)setClientHeadersForRequest:(NSMutableURLRequest *)theRequest
{
	/* Set headers for client information, for tracking purposes at Twitter. */
	[theRequest setValue:DEFAULT_CLIENT_NAME forHTTPHeaderField:@"X-Twitter-Client"];
	[theRequest setValue:DEFAULT_CLIENT_VERSION forHTTPHeaderField:@"X-Twitter-Client-Version"];
	[theRequest setValue:DEFAULT_CLIENT_URL forHTTPHeaderField:@"X-Twitter-Client-URL"];
}

- (NSString *)urlStringWithPath:(NSString *)path
{
	NSString *urlString = [NSString stringWithFormat:@"%@://%@/%@", (secureConnection) ? @"https":@"http", TWITTER_DOMAIN, path];
	return urlString;
}

- (OAMutableURLRequest *)requestWithURL:(NSURL *)url
{
	OAMutableURLRequest *theRequest = [[[OAMutableURLRequest alloc] initWithURL:url
	                                                                   consumer:consumer
	                                                                      token:accessToken
	                                                                      realm:nil
	                                                          signatureProvider:nil] autorelease];
	return theRequest;
}

- (void)setRequest:(NSMutableURLRequest *)request body:(NSString *)body forMethod:(NSString *)method
{
	if(!method || !body)
	{
		return;
	}
	/* Set the request body if this is a POST request. */
	if([method isEqualToString:@"POST"])
	{
		[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	}
}

- (NSString *)encodeString:(NSString *)string
{
	NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
	                                                                       (CFStringRef)string,
	                                                                       NULL,
	                                                                       (CFStringRef)@";/?:@&=$+{}<>,",
	                                                                       kCFStringEncodingUTF8);
	return [result autorelease];
}

- (void)sendRequestWithMethod:(NSString *)method
                         path:(NSString *)path
              queryParameters:(NSDictionary *)params
                         body:(NSString *)body
                      handler:(GenericResultHandler)handler
{
	NSString *urlString = [self urlStringWithPath:path];
	NSURL *finalURL = [NSURL URLWithString:urlString];
	if(!finalURL)
	{
		return;
	}
	OAMutableURLRequest *theRequest = [self requestWithURL:finalURL];
	if(method)
	{
		[theRequest setHTTPMethod:method];
	}
	[theRequest setHTTPShouldHandleCookies:NO];

	[self setClientHeadersForRequest:theRequest];
	[self setRequest:theRequest body:body forMethod:method];

	/* DON'T MODIFY THE REQUEST AFTER THIS!! */
	[theRequest prepare];
	[Seriously oauthRequest:theRequest options:nil handler:[self jsonHandlerWithEngineHandler:handler]];
}

- (void)getTimelineForScreenname:(NSString *)name withHandler:(NSArrayResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/user_timeline/%@.%@", name, API_FORMAT];
	[self sendRequestWithMethod:nil path:path queryParameters:nil body:nil handler:(GenericResultHandler)handler];
}

- (void)sendUpdate:(NSString *)message withHandler:(NSDictionaryResultHandler)handler
{
	NSString *path = [NSString stringWithFormat:@"statuses/update.%@", API_FORMAT];
	NSString *encoded = [self encodeString:message];
	NSString *status = [NSString stringWithFormat:@"status=%@", encoded];
	[self sendRequestWithMethod:@"POST" path:path queryParameters:nil body:status handler:(GenericResultHandler)handler];
}

@end
