/*
 *  ADEngineBlock.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 1/11/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlock_Private.h"
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
        ADEngineBlockRequestBuilder *requestBuilder = [[[ADEngineBlockRequestBuilder alloc] initWithAuthData:authData consumerKey:key consumerSecret:secret] autorelease];
        self.requestBuilder = requestBuilder;
    }
    return self;
}

- (NSString *)screenname
{
    return self.requestBuilder.screenname;
}

- (void)dealloc
{
    [super dealloc];
}

- (BOOL)isAuthorizedForScreenname:(NSString *)name
{
    return [self.requestBuilder isAuthorizedForScreenname:name];
}

@end
