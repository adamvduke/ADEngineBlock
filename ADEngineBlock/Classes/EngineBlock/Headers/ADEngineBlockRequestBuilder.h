/*  
 *  ADEngineBlockRequestBuilder.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 5/18/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@class OAMutableURLRequest;
@class OAToken;
@class OAConsumer;

@interface ADEngineBlockRequestBuilder : NSObject {
    
    NSString *screenname;
    OAConsumer *consumer;
	OAToken *accessToken;
}

@property (nonatomic, retain) NSString *screenname;

#pragma mark -
#pragma mark ADEngineBlockRequestBuilder life cycle
- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret;
- (BOOL)isAuthorizedForScreenname:(NSString *)name;

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
#pragma mark NSURLRequest helper methods
- (OAMutableURLRequest *)requestWithURL:(NSURL *)url;
- (NSString *)urlStringWithPath:(NSString *)path;
- (NSString *)encodeString:(NSString *)string;
- (NSString *)queryStringWithBase:(NSString *)base parameters:(NSDictionary *)params prefixed:(BOOL)prefixed;
- (void)setClientHeadersForRequest:(NSMutableURLRequest *)theRequest;
- (void)setRequest:(NSMutableURLRequest *)request body:(NSString *)body forMethod:(NSString *)method;

#pragma mark -
#pragma mark Send Request
- (NSURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path body:(NSString *)body params:(NSDictionary *)params;

@end
