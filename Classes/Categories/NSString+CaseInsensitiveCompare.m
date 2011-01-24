/* */

/*  NSString+CaseInsensitive.m
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/16/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "NSString+CaseInsensitiveCompare.h"

@implementation NSString (CaseInsensitiveCompare)

- (BOOL)isEqualIgnoreCase:(NSString *)string
{
	return ([self caseInsensitiveCompare:string] == NSOrderedSame);
}

@end