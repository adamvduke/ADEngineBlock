/* */

/*  AbstractEngineBlock.m
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/29/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "AbstractEngineBlock.h"
#import "NSString+CaseInsensitiveCompare.h"
#import "OAMutableURLRequest.h"
#import "Seriously.h"
#import <JSON/JSON.h>

#define TWITTER_DOMAIN          @"api.twitter.com"
#define TWITTER_SEARCH_DOMAIN   @"search.twitter.com"
#define HTTP_POST_METHOD        @"POST"

#define DEFAULT_CLIENT_NAME     @"EngineBlock"
#define DEFAULT_CLIENT_VERSION  @"0.2"
#define DEFAULT_CLIENT_URL      @"http://github.com/adamvduke"
#define DEFAULT_CLIENT_TOKEN    @"adtwitterengine"

@implementation AbstractEngineBlock

@synthesize screen_name;

#pragma mark -
#pragma mark pre-defined blocks

- ( void (^)(id data, NSHTTPURLResponse *response, NSError *error) )jsonHandlerWithEngineHandler:(GenericResultHandler)handler;
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
#pragma mark AbstractEngineBlock life cycle
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

- (void)dealloc
{
	TT_RELEASE_SAFELY(screen_name);
	TT_RELEASE_SAFELY(accessToken);
	TT_RELEASE_SAFELY(consumer);
	[super dealloc];
}

- (void)setAccessTokenWithAuthData:(NSString *)authData
{
	TT_RELEASE_SAFELY(accessToken);
	if( !IsEmpty(authData) )
	{
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:authData];
		self.screen_name = [self screennameFromAuthData:authData];
	}
}

- (void)setConsumerWithKey:(NSString *)key secret:(NSString *)secret
{
	consumer = [[OAConsumer alloc] initWithKey:key secret:secret];
}

#pragma mark -
#pragma mark Helper methods
- (NSString *)screennameFromAuthData:(NSString *)authData
{
	NSString *name = [self valueForKey:@"screen_name" inAuthData:authData];
	return name;
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
	if([name isEqualIgnoreCase:self.screen_name])
	{
		return [self hasValidAccessToken:accessToken];
	}
	return NO;
}

#pragma mark -
#pragma mark NSURLRequest helper methods
- (OAMutableURLRequest *)requestWithURL:(NSURL *)url
{
	OAMutableURLRequest *theRequest = [[[OAMutableURLRequest alloc] initWithURL:url
	                                                                   consumer:consumer
	                                                                      token:accessToken
	                                                                      realm:nil
	                                                          signatureProvider:nil] autorelease];
	return theRequest;
}

- (NSString *)urlStringWithPath:(NSString *)path
{
	NSString *urlString = [NSString stringWithFormat:@"%@://%@/%@", (secureConnection) ? @"https":@"http", TWITTER_DOMAIN, path];
	return urlString;
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

- (NSString *)queryStringWithBase:(NSString *)base parameters:(NSDictionary *)params prefixed:(BOOL)prefixed
{
	/* Append base if specified. */
	NSMutableString *str = [NSMutableString stringWithCapacity:0];
	if(base)
	{
		[str appendString:base];
	}
	/* Append each name-value pair. */
	if(params)
	{
		int i;
		NSArray *names = [params allKeys];
		for(i = 0; i < [names count]; i++){
			if(i == 0 && prefixed)
			{
				[str appendString:@"?"];
			}
			else
			if(i > 0)
			{
				[str appendString:@"&"];
			}
			NSString *name = [names objectAtIndex:i];
			[str appendString:[NSString stringWithFormat:@"%@=%@",
			                   name, [self encodeString:[params objectForKey:name]]]];
		}
	}

	return str;
}

- (void)setClientHeadersForRequest:(NSMutableURLRequest *)theRequest
{
	/* Set headers for client information, for tracking purposes at Twitter. */
	[theRequest setValue:DEFAULT_CLIENT_NAME forHTTPHeaderField:@"X-Twitter-Client"];
	[theRequest setValue:DEFAULT_CLIENT_VERSION forHTTPHeaderField:@"X-Twitter-Client-Version"];
	[theRequest setValue:DEFAULT_CLIENT_URL forHTTPHeaderField:@"X-Twitter-Client-URL"];
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

#pragma mark -
#pragma mark Send Request
- (void)sendRequestWithMethod:(NSString *)method path:(NSString *)path body:(NSString *)body handler:(GenericResultHandler)handler
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

@end
