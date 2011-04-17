/* */

/*  RootViewController.h
 *  EngineBlockDemo
 *
 *  Created by Adam Duke on 1/13/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "ADOAuthOOBViewController.h"
#import <UIKit/UIKit.h>

@class EngineBlock;

@interface RootViewController : UITableViewController <ADOAuthOOBViewControllerDelegate>
{
	EngineBlock *engine;
	NSString *screenname;
	NSMutableArray *tweets;
	UIBarButtonItem *leftBarButton;
	UIBarButtonItem *rightBarButton;
}

@property (nonatomic, retain) EngineBlock *engine;
@property (nonatomic, retain) NSString *screenname;
@property (nonatomic, retain) NSMutableArray *tweets;
@property (nonatomic, retain) UIBarButtonItem *leftBarButton;
@property (nonatomic, retain) UIBarButtonItem *rightBarButton;

@end
