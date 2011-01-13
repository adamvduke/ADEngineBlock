/* */

/*  EngineBlockDemoAppDelegate.h
 *  EngineBlockDemo
 *
 *  Created by Adam Duke on 1/13/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@interface EngineBlockDemoAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

