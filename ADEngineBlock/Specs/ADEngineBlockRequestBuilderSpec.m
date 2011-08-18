/*  
 *  ADEngineBlockRequestBuilderSpec.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 5/18/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "SpecHelper.h"
#import "ADEngineBlockRequestBuilder.h"

SPEC_BEGIN(ADEngineBlockRequestBuilderSpec)
describe(@"ADEngineBlockRequestBuilder", ^{

    describe(@"initialization failures", ^{

        it(@"should raise an exception, when trying to init with blank data", ^{
            @try{
                [[[ADEngineBlockRequestBuilder alloc] initWithAuthData:@"" consumerKey:@"aKey" consumerSecret:@"aSecret"] autorelease];
            }
            @catch(id exception){
                NSAssert([[exception name] isEqual:@"EBInvalidArgumentException"], @"ADEngineBlockRequestBuilder threw the wrong exception");
                return;
            }
            fail(@"ADEngineBlockRequestBuilder failed to raise an exception");
        });

        it(@"should raise an exception, when trying to init with blank key", ^{
            @try{
                [[[ADEngineBlockRequestBuilder alloc] initWithAuthData:@"data" consumerKey:@"" consumerSecret:@"aSecret"] autorelease];
            }
            @catch(id exception){
                NSAssert([[exception name] isEqual:@"EBInvalidArgumentException"], @"ADEngineBlockRequestBuilder threw the wrong exception");
                return;
            }
            fail(@"ADEngineBlockRequestBuilder failed to raise an exception");
        });

        it(@"should raise an exception, when trying to init with blank secret", ^{
            @try{
                [[[ADEngineBlockRequestBuilder alloc] initWithAuthData:@"data" consumerKey:@"aKey" consumerSecret:@""] autorelease];
            }
            @catch(id exception){
                NSAssert([[exception name] isEqual:@"EBInvalidArgumentException"], @"ADEngineBlockRequestBuilder threw the wrong exception");
                return;
            }
            fail(@"ADEngineBlockRequestBuilder failed to raise an exception");
        });
    });

    describe(@"valid requests", ^{

        beforeEach(^{
            ADEngineBlockRequestBuilder *builder = [[[ADEngineBlockRequestBuilder alloc] initWithAuthData:@"data" 
                                                                                              consumerKey:@"key" 
                                                                                           consumerSecret:@"secret"]autorelease];
            [[SpecHelper specHelper].sharedExampleContext setObject:builder forKey:@"builder"];
        });

        it(@"should produce a valid request for fetching the public timeline", ^{
            ADEngineBlockRequestBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
            NSString *path = @"statuses/public_timeline.json";
            NSDictionary *params = nil;
            NSURLRequest *request = [builder requestWithMethod:nil path:path body:nil params:params];

            NSString *requestString = [[request URL] description];
            NSAssert([requestString isEqual:@"https://api.twitter.com/1/statuses/public_timeline.json"], @"ADEngineBlockRequestBuilder built the incorrect url for the request");
            
            NSString *clientVersion = [request valueForHTTPHeaderField:@"X-Twitter-Client-Version"];
            NSAssert([clientVersion isEqual:@"0.2"], @"ADEngineBlockRequestBuilder built the request with the wrong client version");
            
            NSString *clientName = [request valueForHTTPHeaderField:@"X-Twitter-Client"];
            NSAssert([clientName isEqual:@"ADEngineBlock"], @"ADEngineBlockRequestBuilder built the request with the wrong client name");
            
            NSString *clientURL = [request valueForHTTPHeaderField:@"X-Twitter-Client-Url"];
            NSAssert([clientURL isEqual:@"http://github.com/adamvduke"], @"ADEngineBlockRequestBuilder built the request with the wrong client url");
            
            //Authorization : OAuth realm="", oauth_consumer_key="key", oauth_signature_method="HMAC-SHA1", oauth_signature="YKJZynEgtcRMhO3OKemkoC4e5sA%3D", oauth_timestamp="1313584689", oauth_nonce="C0BF3104-C5DD-4916-9303-628767485375", oauth_version="1.0"
            NSString *authHeader = [[[request valueForHTTPHeaderField:@"Authorization"] substringFromIndex:5]stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSArray *parts = [authHeader componentsSeparatedByString:@","];
            NSAssert([parts count] == 7, @"The Authorization header does not have the correct number of elements");
            
            NSAssert([[parts objectAtIndex:0] hasPrefix:@"realm="], @"The authorization header is busted");
            NSAssert([[parts objectAtIndex:1] hasPrefix:@"oauth_consumer_key="], @"The authorization header is busted");
            NSAssert([[parts objectAtIndex:2] hasPrefix:@"oauth_signature_method="], @"The authorization header is busted");
            NSAssert([[parts objectAtIndex:3] hasPrefix:@"oauth_signature="], @"The authorization header is busted");
            NSAssert([[parts objectAtIndex:4] hasPrefix:@"oauth_timestamp="], @"The authorization header is busted");
            NSAssert([[parts objectAtIndex:5] hasPrefix:@"oauth_nonce="], @"The authorization header is busted");
            NSAssert([[parts objectAtIndex:6] hasPrefix:@"oauth_version="], @"The authorization header is busted");
        });

    });
});
SPEC_END