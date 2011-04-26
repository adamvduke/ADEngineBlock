/* */

/*  ADEngineBlock_Private.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 2/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */


#import <UIKit/UIKit.h>
#import "ADEngineBlock.h"

#define API_FORMAT         @"json"
#define MAX_MESSAGE_LENGTH 140

@class OAMutableURLRequest;
@class OAToken;

typedef void (^GenericResultHandler)(id result, NSError *error);

@interface ADEngineBlock ()

@property (nonatomic, retain) NSString *_screenname;

#pragma mark -
#pragma mark OAuth
- (void)setAccessTokenWithAuthData:(NSString *)authData;
- (void)setConsumerWithKey:(NSString *)key secret:(NSString *)secret;

#pragma mark -
#pragma mark Helper methods
- (NSString *)screennameFromAuthData:(NSString *)authData;
- (NSString *)valueForKey:(NSString *)aKey inAuthData:(NSString *)authData;
- (BOOL)hasValidAccessToken:(OAToken *)token;

#pragma mark -
#pragma mark pre-defined blocks
/* returns a block that tests a "tuple" e.g.(screen_name=adamvduke)
 * and checks to see if the element to the left of the = sign
 * is equivalent to the given key
 */
- ( BOOL (^)(id obj, NSUInteger idx, BOOL *stop) )blockTestTupleForKey:(NSString *)aKey;

@end


@interface ADEngineBlock (RequestHandling)

#pragma mark -
#pragma mark pre-defined blocks
- ( void (^)(id data, NSHTTPURLResponse *response, NSError *error) )jsonHandlerWithEngineHandler:(GenericResultHandler)handler;

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
