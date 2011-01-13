/* */

/*  RootViewController.h
 *  EngineBlockDemo
 *
 *  Created by Adam Duke on 1/13/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "AuthorizeViewController.h"
#import <UIKit/UIKit.h>

@class EngineBlock;

@interface RootViewController : UITableViewController <AuthorizeViewControllerDelegate>
{
	EngineBlock *engine;
	NSString *screenname;
	NSArray *tweets;
	NSDictionary *images;
}

@property (nonatomic, retain) EngineBlock *engine;
@property (nonatomic, retain) NSString *screenname;
@property (nonatomic, retain) NSArray *tweets;
@property (nonatomic, retain) NSDictionary *images;

@end
