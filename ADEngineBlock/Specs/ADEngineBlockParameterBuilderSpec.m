/*  
 *  ADEngineBlockParameterBuilderSpec.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 5/19/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "SpecHelper.h"
#import "ADEngineBlockParameterBuilder.h"

SPEC_BEGIN(ADEngineBlockParameterBuilderSpec)
describe(@"ADEngineBlockParameterBuilder", ^{

    beforeEach(^{
        ADEngineBlockParameterBuilder *builder = [[[ADEngineBlockParameterBuilder alloc]init]autorelease];
        [[SpecHelper specHelper].sharedExampleContext setObject:builder forKey:@"builder"];
    });

    describe(@"the method - (NSDictionary *)trimUser:(BOOL)trimUser includeEntities:(BOOL)includeEntities", ^{

        it(@"should return a dictionary", ^{
            ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
            id result = [builder trimUser:NO includeEntities:NO];
            BOOL isDictionary = [result isKindOfClass:[NSDictionary class]];
            NSAssert(isDictionary, @"the result is not a dictionary");
        });

        it(@"should return a dictionary with 2 entries", ^{
            ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
            NSDictionary *result = [builder trimUser:NO includeEntities:NO];
            NSUInteger count = [result count];
            NSAssert(count == 2, @"the result has the wrong number of entries");
        });

        describe(@"the result of trimUser:NO includeEntities:NO", ^{

            it(@"should return a dictionary with the value '0' for the key trim_user", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:NO includeEntities:NO];
                NSString *trimUser = [result valueForKey:@"trim_user"];
                NSAssert([trimUser isEqual:@"0"], @"trim_user does not have the value '0'");
            });

            it(@"should return a dictionary with the value '0' for the key include_entities", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:NO includeEntities:NO];
                NSString *trimUser = [result valueForKey:@"include_entities"];
                NSAssert([trimUser isEqual:@"0"], @"include_entities does not have the value '0'");
            });
        });

        describe(@"the result of trimUser:YES includeEntities:NO", ^{

            it(@"should return a dictionary with the value '1' for the key trim_user", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:YES includeEntities:NO];
                NSString *trimUser = [result valueForKey:@"trim_user"];
                NSAssert([trimUser isEqual:@"1"], @"trim_user does not have the value '1'");
            });

            it(@"should return a dictionary with the value '0' for the key include_entities", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:YES includeEntities:NO];
                NSString *trimUser = [result valueForKey:@"include_entities"];
                NSAssert([trimUser isEqual:@"0"], @"include_entities does not have the value '0'");
            });
        });

        describe(@"the result of trimUser:NO includeEntities:YES", ^{

            it(@"should return a dictionary with the value '0' for the key trim_user", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:NO includeEntities:YES];
                NSString *trimUser = [result valueForKey:@"trim_user"];
                NSAssert([trimUser isEqual:@"0"], @"trim_user does not have the value '0'");
            });

            it(@"should return a dictionary with the value '1' for the key include_entities", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:NO includeEntities:YES];
                NSString *trimUser = [result valueForKey:@"include_entities"];
                NSAssert([trimUser isEqual:@"1"], @"include_entities does not have the value '1'");
            });
        });

        describe(@"the result of trimUser:YES includeEntities:YES", ^{

            it(@"should return a dictionary with the value '1' for the key trim_user", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:YES includeEntities:YES];
                NSString *trimUser = [result valueForKey:@"trim_user"];
                NSAssert([trimUser isEqual:@"1"], @"trim_user does not have the value '1'");
            });

            it(@"should return a dictionary with the value '1' for the key include_entities", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder trimUser:YES includeEntities:YES];
                NSString *trimUser = [result valueForKey:@"include_entities"];
                NSAssert([trimUser isEqual:@"1"], @"include_entities does not have the value '1'");
            });
        });
    });

    describe(@"the method - (NSDictionary *)sinceId:(unsigned long long)sinceId maxId:(unsigned long long)maxId count:(int)count page:(int)page", ^{

        it(@"should return a dictionary", ^{
            ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
            id result = [builder sinceId:0 maxId:0 count:0 page:0];
            BOOL isDictionary = [result isKindOfClass:[NSDictionary class]];
            NSAssert(isDictionary, @"the result is not a dictionary");
        });

        describe(@"all inputs have the value 0", ^{

            it(@"should have no entries", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                NSDictionary *result = [builder sinceId:0 maxId:0 count:0 page:0];
                NSAssert([result count] == 0, @"the result should not contain any entries");
            });
        });

        describe(@"1 input has a value greater than 0", ^{

            describe(@"sinceId has a value greater than 0", ^{

                it(@"should add an entry to the dictionary, for the key since_id", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:randomId maxId:0 count:0 page:0];
                    NSAssert([result count] == 1, @"the result should contain 1 entry");
                    NSString *sinceId = [result valueForKey:@"since_id"];
                    NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                });
            });

            describe(@"maxId has a value greater than 0", ^{
                it(@"should add an entry to the dictionary, for the key max_id", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:0 maxId:randomId count:0 page:0];
                    NSAssert([result count] == 1, @"the result should contain 1 entry");
                    NSString *sinceId = [result valueForKey:@"max_id"];
                    NSAssert([sinceId isEqual:randomIdString], @"the key max_id does not have the right value");
                });
            });

            describe(@"count has a value greater than 0", ^{
                it(@"should add an entry to the dictionary, for the key count", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomInt = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomInt];
                    NSDictionary *result = [builder sinceId:0 maxId:0 count:randomInt page:0];
                    NSAssert([result count] == 1, @"the result should contain 1 entry");
                    NSString *sinceId = [result valueForKey:@"count"];
                    NSAssert([sinceId isEqual:randomIdString], @"the key count does not have the right value");
                });
            });

            describe(@"page has a value greater than 0", ^{
                it(@"should add an entry to the dictionary, for the key page", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomInt = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomInt];
                    NSDictionary *result = [builder sinceId:0 maxId:0 count:0 page:randomInt];
                    NSAssert([result count] == 1, @"the result should contain 1 entry");
                    NSString *sinceId = [result valueForKey:@"page"];
                    NSAssert([sinceId isEqual:randomIdString], @"the key page does not have the right value");
                });
            });
        });

        describe(@"2 inputs have a value greater than 0", ^{

            describe(@"sinceId and maxId have values greater than 0", ^{

                it(@"should add entries to the dictionary, for the keys since_id and max_id", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:randomId maxId:randomId count:0 page:0];
                    NSAssert([result count] == 2, @"the result should contain 2 entries");
                    NSString *sinceId = [result valueForKey:@"since_id"];
                    NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                    NSString *maxId = [result valueForKey:@"max_id"];
                    NSAssert([maxId isEqual:randomIdString], @"the key max_id does not have the right value");
                });
            });

            describe(@"sinceId and count have values greater than 0", ^{
                it(@"should add entries to the dictionary, for the keys since_id and count", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:randomId maxId:0 count:randomId page:0];
                    NSAssert([result count] == 2, @"the result should contain 2 entries");
                    NSString *sinceId = [result valueForKey:@"since_id"];
                    NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                    NSString *count = [result valueForKey:@"count"];
                    NSAssert([count isEqual:randomIdString], @"the key count does not have the right value");
                });
            });

            describe(@"sinceId and page have values greater than 0", ^{
                it(@"should add entries to the dictionary, for the keys since_id and count", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:randomId maxId:0 count:0 page:randomId];
                    NSAssert([result count] == 2, @"the result should contain 2 entries");
                    NSString *sinceId = [result valueForKey:@"since_id"];
                    NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                    NSString *page = [result valueForKey:@"page"];
                    NSAssert([page isEqual:randomIdString], @"the key count does not have the right value");
                });
            });

            describe(@"maxId and count have values greater than 0", ^{

                it(@"should add entries to the dictionary, for the keys since_id and count", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:0 maxId:randomId count:randomId page:0];
                    NSAssert([result count] == 2, @"the result should contain 2 entries");
                    NSString *maxId = [result valueForKey:@"max_id"];
                    NSAssert([maxId isEqual:randomIdString], @"the key count does not have the right value");
                    NSString *count = [result valueForKey:@"count"];
                    NSAssert([count isEqual:randomIdString], @"the key since_id does not have the right value");
                });
            });

            describe(@"maxId and page have values greater than 0", ^{
                it(@"should add entries to the dictionary, for the keys since_id and count", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:0 maxId:randomId count:0 page:randomId];
                    NSAssert([result count] == 2, @"the result should contain 2 entries");
                    NSString *maxId = [result valueForKey:@"max_id"];
                    NSAssert([maxId isEqual:randomIdString], @"the key count does not have the right value");
                    NSString *page = [result valueForKey:@"page"];
                    NSAssert([page isEqual:randomIdString], @"the key since_id does not have the right value");
                });
            });

            describe(@"count and page have values greater than 0", ^{
                it(@"should add entries to the dictionary, for the keys since_id and count", ^{
                    ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                    int randomId = foo4random();
                    NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                    NSDictionary *result = [builder sinceId:0 maxId:0 count:randomId page:randomId];
                    NSAssert([result count] == 2, @"the result should contain 2 entries");
                    NSString *maxId = [result valueForKey:@"count"];
                    NSAssert([maxId isEqual:randomIdString], @"the key count does not have the right value");
                    NSString *page = [result valueForKey:@"page"];
                    NSAssert([page isEqual:randomIdString], @"the key since_id does not have the right value");
                });
            });
        });

        describe(@"3 inputs have a value greater than 0", ^{

            it(@"should add entries to the dictionary, for the keys since_id, max_id, and count", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                int randomId = foo4random();
                NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                NSDictionary *result = [builder sinceId:randomId maxId:randomId count:randomId page:0];
                NSAssert([result count] == 3, @"the result should contain 3 entries");
                NSString *sinceId = [result valueForKey:@"since_id"];
                NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                NSString *maxId = [result valueForKey:@"max_id"];
                NSAssert([maxId isEqual:randomIdString], @"the key max_id does not have the right value");
                NSString *count = [result valueForKey:@"count"];
                NSAssert([count isEqual:randomIdString], @"the key count does not have the right value");
            });

            it(@"should add entries to the dictionary, for the keys since_id, max_id, and count", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                int randomId = foo4random();
                NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                NSDictionary *result = [builder sinceId:randomId maxId:randomId count:0 page:randomId];
                NSAssert([result count] == 3, @"the result should contain 3 entries");
                NSString *sinceId = [result valueForKey:@"since_id"];
                NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                NSString *maxId = [result valueForKey:@"max_id"];
                NSAssert([maxId isEqual:randomIdString], @"the key max_id does not have the right value");
                NSString *page = [result valueForKey:@"page"];
                NSAssert([page isEqual:randomIdString], @"the key page does not have the right value");
            });

            it(@"should add entries to the dictionary, for the keys since_id, max_id, and count", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                int randomId = foo4random();
                NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                NSDictionary *result = [builder sinceId:randomId maxId:0 count:randomId page:randomId];
                NSAssert([result count] == 3, @"the result should contain 3 entries");
                NSString *sinceId = [result valueForKey:@"since_id"];
                NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                NSString *count = [result valueForKey:@"count"];
                NSAssert([count isEqual:randomIdString], @"the key count does not have the right value");
                NSString *page = [result valueForKey:@"page"];
                NSAssert([page isEqual:randomIdString], @"the key page does not have the right value");
            });

            it(@"should add entries to the dictionary, for the keys since_id, max_id, and count", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                int randomId = foo4random();
                NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                NSDictionary *result = [builder sinceId:0 maxId:randomId count:randomId page:randomId];
                NSAssert([result count] == 3, @"the result should contain 3 entries");
                NSString *maxId = [result valueForKey:@"max_id"];
                NSAssert([maxId isEqual:randomIdString], @"the key max_id does not have the right value");
                NSString *count = [result valueForKey:@"count"];
                NSAssert([count isEqual:randomIdString], @"the key count does not have the right value");
                NSString *page = [result valueForKey:@"page"];
                NSAssert([page isEqual:randomIdString], @"the key page does not have the right value");
            });
        });

        describe(@"all inputs have a value greater than 0", ^{
            it(@"should add entries to the dictionary, for the keys since_id, max_id, and count", ^{
                ADEngineBlockParameterBuilder *builder = [[SpecHelper specHelper].sharedExampleContext objectForKey:@"builder"];
                int randomId = foo4random();
                NSString *randomIdString = [NSString stringWithFormat:@"%d", randomId];
                NSDictionary *result = [builder sinceId:randomId maxId:randomId count:randomId page:randomId];
                NSAssert([result count] == 4, @"the result should contain 3 entries");
                NSString *sinceId = [result valueForKey:@"since_id"];
                NSAssert([sinceId isEqual:randomIdString], @"the key since_id does not have the right value");
                NSString *maxId = [result valueForKey:@"max_id"];
                NSAssert([maxId isEqual:randomIdString], @"the key max_id does not have the right value");
                NSString *count = [result valueForKey:@"count"];
                NSAssert([count isEqual:randomIdString], @"the key count does not have the right value");
                NSString *page = [result valueForKey:@"page"];
                NSAssert([page isEqual:randomIdString], @"the key page does not have the right value");
            });
        });
    });
});
SPEC_END