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
            
            for(NSString *key in [request allHTTPHeaderFields]){
                const char *_key = [key cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_value = [[request valueForHTTPHeaderField:key] cStringUsingEncoding:NSUTF8StringEncoding];
                printf("\n %s : %s \n", _key, _value);
                //printf("\n");
            }
            //NSLog(@"%@", [request description]);
        });

//        it(@"should produce a valid request for updating a status", ^{
//            ADEngineBlockRequestBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
//            NSString *path = @"statuses/update.json";
//            NSDictionary *params = nil;
//            NSURLRequest *request = [builder requestWithMethod:nil path:path body:nil params:params];
//            
//            for(NSString *key in [request allHTTPHeaderFields]){
//                NSLog(@"%@ : %@", key, [request valueForHTTPHeaderField:key]);
//                printf("\n");
//            }
//            NSLog(@"%@", [request description]);
//        });
    });
});
SPEC_END