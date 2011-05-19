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
    
    describe(@"the method - (NSDictionary *)trimUser:(BOOL)trimUser includeEntities:(BOOL)includeEntities;", ^{
        
        beforeEach(^{
            ADEngineBlockParameterBuilder *builder = [[[ADEngineBlockParameterBuilder alloc]init]autorelease];
            [[SpecHelper specHelper].sharedExampleContext setObject:builder forKey:@"builder"];
        });
        
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
});
SPEC_END