/* */

/*  ADEngineBlock+RequestHandling.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 1/29/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "ADEngineBlock_Private.h"
#import "OAMutableURLRequest.h"
#import "Seriously.h"
#import "JSON.h"

#define TWITTER_DOMAIN          @"api.twitter.com"
#define API_VERSION             @"1"
#define URL_BASE                [NSString stringWithFormat:@"%@/%@", TWITTER_DOMAIN, API_VERSION]

#define TWITTER_SEARCH_DOMAIN   @"search.twitter.com"
#define HTTP_POST_METHOD        @"POST"

#define DEFAULT_CLIENT_NAME     @"ADEngineBlock"
#define DEFAULT_CLIENT_VERSION  @"0.2"
#define DEFAULT_CLIENT_URL      @"http://github.com/adamvduke"
#define DEFAULT_CLIENT_TOKEN    @"adtwitterengine"

@implementation ADEngineBlock (RequestHandling)

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
	NSString *urlString = [NSString stringWithFormat:@"https://%@/%@", URL_BASE, path];
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
