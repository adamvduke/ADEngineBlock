/*
 *  ADEngineBlock.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock.h"
#import "ADEngineBlockParameterBuilder.h"
#import "ADEngineBlockRequestBuilder.h"
#import "NSString+CaseInsensitiveCompare.h"
#import "OAConsumer.h"
#import "OAToken.h"

@implementation ADEngineBlock

#pragma mark -
#pragma mark ADEngineBlock life cycle
- (id)initWithAuthData:(NSString *)authData consumerKey:(NSString *)key consumerSecret:(NSString *)secret
{
    self = [super init];
    if(self)
    {
        requestBuilder = [[ADEngineBlockRequestBuilder alloc] initWithAuthData:authData consumerKey:key consumerSecret:secret];
    }
    return self;
}

- (NSString *)screenname
{
    return requestBuilder.screenname;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(requestBuilder);
    [super dealloc];
}

- (BOOL)isAuthorizedForScreenname:(NSString *)name
{
    return [requestBuilder isAuthorizedForScreenname:name];
}

@end
