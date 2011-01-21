/* */

/*  RootViewController.m
 *  EngineBlockDemo
 *
 *  Created by Adam Duke on 1/13/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "EngineBlock.h"
#import "RootViewController.h"

/* Things needed for OAuth workflow */
#define kConsumerKey @"aO3AW956gU8hauOcqz51w"
#define kConsumerSecret @"vRDNF3k4WJvMQiqIxsrKcfva0MHyZI7kJouqUCGwWn0"
#define kRequestTokenURLString @"http://twitter.com/oauth/request_token"
#define kAccessTokenURLString @"http://twitter.com/oauth/access_token"
#define kAuthorizeURLString @"http://twitter.com/oauth/authorize"

#define kAuthDataKeyPrefix @"kAuthDataKeyPrefix"

@interface RootViewController (Private)

- (NSString *)authDataKeyForScreenname:(NSString *)screenname;
- (NSString *)retrieveOAuthDataForScreenname:(NSString *)screenname;
- (EngineBlock *)engineForScreenname:(NSString *)screenname;
- (NSDictionary *)tweetForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)textForTweetAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation RootViewController

@synthesize engine, screenname, tweets, images;

#pragma mark -
#pragma mark pre-defined blocks
- ( void (^)(NSArray *result, NSError *error) )updateTweetsHandler
{
	/* block magic :-) */
	return [[^(NSArray *result, NSError *error)
	         {
				 if(![result isKindOfClass:[NSArray class]])
				 {
					 NSLog (@"There was a problem");
					 return;
				 }
				 self.tweets = result;
				 [self.tableView reloadData];
			 } copy] autorelease];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	 self.screenname = @"snakes_nbarrels";
	//self.screenname = @"adamvduke";

	/* self.screenname = @"adamcodez"; */
	self.engine = [self engineForScreenname:self.screenname];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	if(![self.engine isAuthorizedForScreenname:self.screenname])
	{
		AuthorizeViewController *controller = [[[AuthorizeViewController alloc] initWithConsumerKey:kConsumerKey
		                                                                             consumerSecret:kConsumerSecret
		                                                                      requestTokenURLString:kRequestTokenURLString
		                                                                       accessTokenURLString:kAccessTokenURLString
		                                                                         authorizeURLString:kAuthorizeURLString
		                                                                                   delegate:self] autorelease];
		[self presentModalViewController:controller animated:YES];
		return;
	}
	if( IsEmpty(self.tweets) )
	{
		[self.engine getTimelineForScreenname:@"sweetpuppyd" withHandler:[self updateTweetsHandler]];
	}
}

- (EngineBlock *)engineForScreenname:(NSString *)name
{
	NSString *authData = [self retrieveOAuthDataForScreenname:name];
	if( !IsEmpty(authData) )
	{
		return [[[EngineBlock alloc] initWithAuthData:authData
		                                      consumerKey:kConsumerKey
		                                   consumerSecret:kConsumerSecret] autorelease];
	}
	return nil;
}

- (void)authCompletedWithData:(NSString *)authData orError:(NSError *)error
{
	if(error)
	{
		NSLog(@"Something went horribly wrong!");
		return;
	}
	self.engine = [[[EngineBlock alloc] initWithAuthData:authData
	                                             consumerKey:kConsumerKey
	                                          consumerSecret:kConsumerSecret] autorelease];
	self.screenname = engine.screenname;
	[self saveOAuthData:authData forScreenname:engine.screenname];
	[self dismissModalViewControllerAnimated:YES];
	[self.engine getTimelineForScreenname:@"sweetpuppyd" withHandler:[self updateTweetsHandler]];
}

#pragma mark -
#pragma mark Table view data source

/* Customize the number of sections in the table view. */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

/* Customize the number of rows in the table view. */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.tweets == nil ? 0 : [self.tweets count];
}

/* Customize the appearance of table view cells. */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont systemFontOfSize:14];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	NSString *text = [self textForTweetAtIndexPath:indexPath];
	cell.textLabel.text = text;
	return cell;
}

/* Return the custom height of the cell based on the content that will be displayed */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *text = [self textForTweetAtIndexPath:indexPath];
	UIFont *font = [UIFont systemFontOfSize:14 ];
	CGSize withinSize = CGSizeMake( 350, 150);
	CGSize size = [text sizeWithFont:font constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
	CGFloat textHeight = size.height + 35;
	return textHeight;
}

- (NSDictionary *)tweetForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
	return tweet;
}

- (NSString *)textForTweetAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *tweet = [self tweetForRowAtIndexPath:indexPath];
	NSString *text = [tweet objectForKey:@"text"];
	return text;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
	/* Releases the view if it doesn't have a superview. */
	[super didReceiveMemoryWarning];

	/* Relinquish ownership any cached data, images, etc that aren't in use. */
}

- (void)viewDidUnload
{
	/* Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	 * For example: self.myOutlet = nil;
	 */
}

#pragma mark -
#pragma mark EngineBlockDelegate

- (NSString *)authDataKeyForScreenname:(NSString *)name
{
	NSString *key = [NSString stringWithFormat:@"%@:%@", kAuthDataKeyPrefix, name];
	key = [key lowercaseString];
	return key;
}

- (void)saveOAuthData:(NSString *)oauthData forScreenname:(NSString *)name
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:oauthData forKey:[self authDataKeyForScreenname:name]];
	[defaults synchronize];
}

- (void)removeOAuthDataForScreenname:(NSString *)name
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey:[self authDataKeyForScreenname:name]];
	[defaults synchronize];
}

- (NSString *)retrieveOAuthDataForScreenname:(NSString *)name
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *authData = [defaults objectForKey:[self authDataKeyForScreenname:name]];
	return authData;
}

- (void)dealloc
{
	[engine release];
	[super dealloc];
}

@end

