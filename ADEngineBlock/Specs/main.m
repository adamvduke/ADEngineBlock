//
//  main.m
//  ADEngineBlock
//
//  Created by Adam Duke on 5/18/11.
//  Copyright 2011 Adam Duke. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Cedar.h"

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
    int retVal = UIApplicationMain(argc, argv, nil, @"CedarApplicationDelegate");
    [pool release];
    return retVal;
}