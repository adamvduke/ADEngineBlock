/*  RootViewController.m
 *  EngineBlockDemo
 *
 *  Created by Adam Duke on 1/13/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import "ADEngineBlock.h"
#import "RootViewController.h"

/* Things needed for OAuth workflow */
#define kConsumerKey @"aO3AW956gU8hauOcqz51w"
#define kConsumerSecret @"vRDNF3k4WJvMQiqIxsrKcfva0MHyZI7kJouqUCGwWn0"
#define kRequestTokenURLString @"http://twitter.com/oauth/request_token"
#define kAccessTokenURLString @"http://twitter.com/oauth/access_token"
#define kAuthorizeURLString @"http://twitter.com/oauth/authorize"

#define kAuthDataKeyPrefix @"kAuthDataKeyPrefix"

@interface RootViewController (Private)

- (void)saveOAuthData:(NSString *)oauthData forScreenname:(NSString *)name;
- (NSString *)authDataKeyForScreenname:(NSString *)screenname;
- (NSString *)retrieveOAuthDataForScreenname:(NSString *)screenname;
- (ADEngineBlock *)engineForScreenname:(NSString *)screenname;

- (void)postStatus;
- (void)fetchStatuses;

@end

@implementation RootViewController

@synthesize engine, screenname, demoMethods;

#pragma mark -
#pragma mark pre-defined blocks
- ( void (^)(id result, NSError *error) )handlerForClass:(Class)class
{
    /* block magic :-) */
    return [[^(id result, NSError *error)
             {
                 if(![result isKindOfClass:class])
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OHNOZ!!"
                                                                     message:@"Something went wrong. Check the log."
                                                                    delegate:self cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                     NSLog (@"%@", [result description]);
                     return;
                 }
                 NSLog (@"%@", [result description]);
             } copy] autorelease];
}

- ( void (^)(NSArray *result, NSError *error) )logNSArrayHandler
{
    return [self handlerForClass:[NSArray class]];
}

- ( void (^)(NSDictionary *result, NSError *error) )logNSDictionaryHandler
{
    return [self handlerForClass:[NSDictionary class]];
}

#pragma mark -
#pragma mark UIViewController lifecycle

- (void)dealloc
{
    [engine release];
    [screenname release];
    [demoMethods release];
    [super dealloc];
}

- (void)loadView
{
    /* add a selector name here and implement the correspoding method */
    self.demoMethods = [NSArray arrayWithObjects:
                        @"homeTimelineWithHandler",
                        @"homeTimelineSinceId",
                        @"mentionsWithHandler",
                        @"mentionsSinceId",
                        @"publicTimelineWithHandler",
                        @"publicTimelineTrimUser",
                        @"checkRateLimit",
                        @"fetchStatuses",
                        @"postStatus",
                        nil];

    [super loadView];
}

- (void)viewDidLoad
{
    self.screenname = @"ADEngineBlock";
    self.engine = [self engineForScreenname:self.screenname];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![self.engine isAuthorizedForScreenname:self.screenname])
    {
        ADOAuthOOBViewController *controller = [[[ADOAuthOOBViewController alloc] initWithConsumerKey:kConsumerKey
                                                                                       consumerSecret:kConsumerSecret
                                                                                requestTokenURLString:kRequestTokenURLString
                                                                                 accessTokenURLString:kAccessTokenURLString
                                                                                   authorizeURLString:kAuthorizeURLString
                                                                                             delegate:self] autorelease];
        [self presentModalViewController:controller animated:YES];
        return;
    }
}

- (ADEngineBlock *)engineForScreenname:(NSString *)name
{
    NSString *authData = [self retrieveOAuthDataForScreenname:name];
    if( !IsEmpty(authData) )
    {
        return [[[ADEngineBlock alloc] initWithAuthData:authData
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
    self.engine = [[[ADEngineBlock alloc] initWithAuthData:authData
                                               consumerKey:kConsumerKey
                                            consumerSecret:kConsumerSecret] autorelease];
    self.screenname = engine.screenname;
    [self saveOAuthData:authData forScreenname:engine.screenname];
    [self dismissModalViewControllerAnimated:YES];
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
    return self.demoMethods == nil ? 0 : [self.demoMethods count];
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
        cell.textLabel.backgroundColor = [UIColor lightGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    cell.textLabel.text = [demoMethods objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark -
#pragma mark Table view delegate
/* Return the custom height of the cell based on the content that will be displayed */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [demoMethods objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:14 ];
    CGSize withinSize = CGSizeMake( 350, 150);
    CGSize size = [text sizeWithFont:font constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
    CGFloat textHeight = size.height + 35;
    return textHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    NSString *methodName = [demoMethods objectAtIndex:row];
    SEL selector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selector])
    {
        [self performSelector:selector];
    }
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

#pragma mark -
#pragma mark Demo methods
- (void)homeTimelineWithHandler
{
    [self.engine homeTimelineWithHandler:[self logNSArrayHandler]];
}

- (void)homeTimelineSinceId
{
    [self.engine homeTimelineSinceId:0 maxId:0 count:5 page:1 trimUser:NO includeEntities:YES withHandler:[self logNSArrayHandler]];
}

- (void)mentionsWithHandler
{
    [self.engine mentionsWithHandler:[self logNSArrayHandler]];
}

- (void)mentionsSinceId
{
    [self.engine mentionsSinceId:0 maxId:0 count:3 page:1 trimUser:YES includeRts:YES includeEntities:YES withHandler:[self logNSArrayHandler]];
}

- (void)publicTimelineWithHandler
{
    [self.engine publicTimelineWithHandler:[self logNSArrayHandler]];
}

- (void)publicTimelineTrimUser
{
    [self.engine publicTimelineTrimUser:YES includeEntities:YES withHandler:[self logNSArrayHandler]];
}

- (void)checkRateLimit
{
    [self.engine rateLimitStatusWithHandler:[self logNSDictionaryHandler]];
}

- (void)postStatus
{
    NSString *date = [[NSDate date] description];
    NSString *message = [NSString stringWithFormat:@"@AdamCodez Posting at: %@", date];
    [self.engine sendUpdate:message
                  inReplyTo:29386843145375744UL
                   latitude:-31.936831f
                  longitude:115.755413f
                    placeId:0
               displayCoord:YES
                   trimUser:NO
            includeEntities:YES
                withHandler:[self logNSDictionaryHandler]];
}

- (void)fetchStatuses
{
    [self.engine userTimelineForScreenname:@"snakes_nbarrels"
                                    userId:0
                                   sinceId:0
                                     maxId:0
                                     count:4
                                      page:2
                                  trimUser:NO
                                includeRts:NO
                           includeEntities:NO
                               withHandler:[self logNSArrayHandler]];
}
@end

