//
//  TTWordPressAppDelegate.m
//  TTWordPress
//
//  Created by Karl Monaghan on 03/06/2011.
//  Copyright 2011 None. All rights reserved.
//

#import "TTWordpressAppDelegate.h"

#import "WPTabBarController.h"

#import "WordPressBlogViewController.h"
#import "WordPressAddCommentViewController.h"

@implementation TTWordpressAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[TTURLRequestQueue mainQueue] setMaxContentLength:0];
	
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeAll;
	
	TTURLMap* map = navigator.URLMap;
	
	[map from:@"*" toViewController:[TTWebController class]];
	
	[map from:@"tt://tabbar" toSharedViewController:[WPTabBarController class]];
    [map from:@"tt://examplepostlist" toSharedViewController:[WordPressBlogViewController class]];
	[map from:@"tt://blog/author/(initWithAuthorId:)" toSharedViewController:[WordPressBlogViewController class]];
	[map from:@"tt://blog/category/(initWithCategoryId:)" toSharedViewController:[WordPressBlogViewController class]];
	[map from:@"tt://blog/post/comment/(initWithPostId:)" toModalViewController:[WordPressAddCommentViewController class]];
    
	[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabbar"]];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
