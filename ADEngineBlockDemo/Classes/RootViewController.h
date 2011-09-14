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

@class ADEngineBlock;

@interface RootViewController : UITableViewController <ADOAuthOOBViewControllerDelegate>
{
	ADEngineBlock *engine;
	NSString *screenname;
    NSArray *demoMethods;
}

@property (nonatomic, retain) ADEngineBlock *engine;
@property (nonatomic, retain) NSString *screenname;
@property (nonatomic, retain) NSArray *demoMethods;

@end
