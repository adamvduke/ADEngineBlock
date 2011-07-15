/*  
 *  CategorySpecs.m
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 5/18/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "SpecHelper.h"
#import "NSString+CaseInsensitiveCompare.h"

SPEC_BEGIN(CaseInsensitiveCompareSpec)
describe(@"NSString+CaseInsensitiveCompare", ^{

	__block NSString *stringUUID = nil;
	__block NSString *capitalCase = nil;
	__block NSString *lowerCase = nil;

	beforeEach(^{
		CFUUIDRef theUUID = CFUUIDCreate(NULL);
		CFStringRef stringRef = CFUUIDCreateString(NULL, theUUID);
		CFRelease(theUUID);
		stringUUID = (NSString *)stringRef;
		capitalCase = [stringUUID uppercaseString];
		lowerCase = [stringUUID lowercaseString];
	});

	afterEach(^{
		[stringUUID release];
	});

	it(@"should respond to isEqualIgnoreCase:", ^{
		NSString *aString = @"aString";
		NSAssert([aString respondsToSelector:@selector(isEqualIgnoreCase:)], @"NSString does not respond to isEqualIgnoreCase");
	});

	it(@"should return true for a comparison of strings of lower case", ^{

		NSString *failureMessage = [NSString stringWithFormat:@"%@ is not equivalent to %@", capitalCase, lowerCase];
		NSString *anotherLowerCase = [NSString stringWithString:lowerCase];
		NSAssert(lowerCase != anotherLowerCase, @"The two strings point to the same object");
		NSAssert([lowerCase isEqualIgnoreCase:anotherLowerCase], failureMessage);
	});

	it(@"should return true for a comparison of strings of upper case", ^{

		NSString *failureMessage = [NSString stringWithFormat:@"%@ is not equivalent to %@, ignoring case", capitalCase, lowerCase];
		NSString *anotherUpperCase = [NSString stringWithString:capitalCase];
		NSAssert(capitalCase != anotherUpperCase, @"The two strings point to the same object");
		NSAssert([capitalCase isEqualIgnoreCase:anotherUpperCase], failureMessage);
	});

	it(@"should return true for a comparison of strings of different case", ^{

		NSString *failureMessage = [NSString stringWithFormat:@"%@ is not equivalent to %@, ignoring case", capitalCase, lowerCase];
		NSAssert([capitalCase isEqualIgnoreCase:lowerCase], failureMessage);
	});

	it(@"should return false for a comparison of different strings", ^{

		NSString *notAUUID = @"OMGnowaI";
		NSString *failureMessage = [NSString stringWithFormat:@"%@ is equivalent to %@, ignoring case", capitalCase, notAUUID];
		BOOL equivalent = [capitalCase isEqualIgnoreCase:notAUUID];
		NSAssert(equivalent == NO , failureMessage);
	});

});
SPEC_END