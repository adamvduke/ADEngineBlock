/*  
 *  NSString+CaseInsensitive.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 1/16/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface NSString (CaseInsensitiveCompare)

- (BOOL)isEqualIgnoreCase:(NSString *)string;

@end
