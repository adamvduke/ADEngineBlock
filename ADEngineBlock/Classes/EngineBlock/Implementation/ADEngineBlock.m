/* */

/*  ADEngineBlock.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "ADEngineBlock_Private.h"
#import "NSString+CaseInsensitiveCompare.h"
#import "OAConsumer.h"
#import "OAToken.h"

@implementation ADEngineBlock

#pragma mark -
#pragma mark pre-defined blocks
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
#pragma mark ADEngineBlock life cycle
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
	}
	return self;
}

- (void)dealloc
{
	TT_RELEASE_SAFELY(screenname);
	TT_RELEASE_SAFELY(accessToken);
	TT_RELEASE_SAFELY(consumer);
	[super dealloc];
}

- (BOOL)isAuthorizedForScreenname:(NSString *)name
{
	if([name isEqualIgnoreCase:self.screenname])
	{
		return [self hasValidAccessToken:accessToken];
	}
	return NO;
}

#pragma mark -
#pragma mark properties

/* public getter for the screenname ivar */
- (NSString *)screenname
{
	return [screenname copy];
}

/* private getter/setter for the screenname ivar
 * the public property is readonly
 */
- (NSString *)_screenname
{
	return screenname;
}

- (void)set_screenname:(NSString *)name
{
	[screenname autorelease];
	screenname = [name retain];
}

- (void)setAccessTokenWithAuthData:(NSString *)authData
{
	TT_RELEASE_SAFELY(accessToken);
	if( !IsEmpty(authData) )
	{
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:authData];
		self._screenname = [self screennameFromAuthData:authData];
	}
}

- (void)setConsumerWithKey:(NSString *)key secret:(NSString *)secret
{
	consumer = [[OAConsumer alloc] initWithKey:key secret:secret];
}

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

@end
