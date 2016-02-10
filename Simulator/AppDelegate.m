/*
 Copyright © 2014-2016 myOS Group.
 
 This application is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 Lesser General Public License for more details.
 
 Contributor(s):
 Amr Aboelela <amraboelela@gmail.com>
 */

#import "AppDelegate.h"
//#import "FileManager.h"
#import "FooterView.h"

@implementation AppDelegate

@synthesize window=_window;

#pragma mark - Life cycle

- (void)dealloc
{
    [_window release];
    //[_launcherVC release];
    [super dealloc];
}

#pragma mark - Delegates

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //FileManagerSetupDirectories();
    CGRect frame = [[UIScreen mainScreen] bounds];
    _window = [[UIWindow alloc] initWithFrame:frame];
    
    FooterView *footerView = [[FooterView alloc] init];
    footerView.delegate = self;
    [_window addSubview:footerView];
    [footerView release];
    
    [_window makeKeyAndVisible];
    
    //DLog(@"self: %@", self);
    //[self performSelector:@selector(loadViews) withObject:nil afterDelay:0.01];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:_launcherVC selector:@selector(gotoHomepage) userInfo:nil repeats:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)homeButtonClicked:(id)sender
{
    //[_launcherVC gotoHomepage];
}

- (void)backButtonClicked:(id)sender
{
    DLog();s
}

#pragma mark - Public functions

@end
