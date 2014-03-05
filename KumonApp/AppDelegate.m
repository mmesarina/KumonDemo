//
//  AppDelegate.m
//  KumonApp
//
//  Created by malena mesarina on 2/10/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"AEwCJLmH3ZOGk8V1Ixrcacp5ga46ZgVxYvmTvXFL"
                  clientKey:@"O1OKJm70bwZLIQLMWWApaiXXrnhtQ15qmjfxxQDI"];
	
	
	
	// Login with user name
	[PFUser logInWithUsernameInBackground:@"Malena Mesarina" password:@"wassi707" block:^(PFUser *user, NSError *error) {
		if (!error) {
			NSLog(@"Login successful");
			
		} else {
			NSLog(@"Error login in");
		}
	}];
	
	
	
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc ] initWithRootViewController:vc];
    self.window.rootViewController = nvc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	
	
	// SET THE BACKGROUND COLOR AND TINT COLOR OF DOTS FOR PAGES
	UIPageControl* proxy =
    [UIPageControl appearanceWhenContainedIn:[UIPageViewController class], nil];
	[proxy setPageIndicatorTintColor:[UIColor blackColor]];
	[proxy setCurrentPageIndicatorTintColor:[UIColor lightGrayColor]];
	[proxy setBackgroundColor: [UIColor colorWithRed:141 green:206 blue:245 alpha:1]];

    return YES;

	
   
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
