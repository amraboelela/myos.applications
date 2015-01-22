/*
 Copyright © 2014 myOS Group.
 
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
#import "SmileyFaceView.h"


@implementation AppDelegate

@synthesize window;
@synthesize layers;
@synthesize blueView;

#pragma mark - Life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //DLog(@"context: %@", context);
    //CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    window.backgroundColor = [UIColor yellowColor];
    //DLog(@"window: %@", window);
    self.blueView = [[[BlueView alloc] initWithFrame:CGRectMake(10,30,300,340)] autorelease];
    //DLog(@"blueView: %@", blueView);
    [window addSubview:blueView];
    [window makeKeyAndVisible];

    SmileyFaceView *smiley = [[[SmileyFaceView alloc] initWithFrame:CGRectMake(40,50,51,51)] autorelease];
    [blueView addSubview:smiley];

    DLog(@"smiley: %@", smiley);
    smiley = [[[SmileyFaceView alloc] initWithFrame:CGRectMake(230,40,50,50)] autorelease];
    [blueView addSubview:smiley];
    smiley = [[[SmileyFaceView alloc] initWithFrame:CGRectMake(240,50,50,50)] autorelease];
    [blueView addSubview:smiley];
    smiley = [[[SmileyFaceView alloc] initWithFrame:CGRectMake(150,140,50,50)] autorelease];
    smiley.backgroundColor = [UIColor greenColor];
    [blueView addSubview:smiley];
    smiley = [[[SmileyFaceView alloc] initWithFrame:CGRectMake(160,165,50,50)] autorelease];
    [blueView addSubview:smiley];

    return YES;
}

- (void)dealloc
{
    [window release];
    [layers release];
    [blueView release];
    [super dealloc];
}

@end

