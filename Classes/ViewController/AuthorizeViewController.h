/* */

/*  AuthorizeViewController.h
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/13/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@class OAConsumer;
@class OAToken;

@protocol AuthorizeViewControllerDelegate<NSObject>

- (void)authCompletedWithData:(NSString *)authData orError:(NSError *)error;
- (void)saveOAuthData:(NSString *)oauthData forScreenname:(NSString *)screenname;
- (void)removeOAuthDataForScreenname:(NSString *)screenname;

@end

@interface AuthorizeViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;

	@private
	NSURL *requestTokenURL;
	NSURL *accessTokenURL;
	NSURL *authorizeURL;

	OAConsumer *consumer;
	OAToken *requestToken;
	NSString *verifier;

	BOOL firstLoad;
	id<AuthorizeViewControllerDelegate> delegate;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) id<AuthorizeViewControllerDelegate> delegate;
@property (nonatomic, retain) NSString *verifier;

- (id)initWithConsumerKey:(NSString *)key
		   consumerSecret:(NSString *)secret
	requestTokenURLString:(NSString *)requestTokenURLString
	 accessTokenURLString:(NSString *)accessTokenURLString
	   authorizeURLString:(NSString *)authorizeURLString
				 delegate:(id)aDelegate;
@end
