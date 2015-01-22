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

#import "CalculatorAppDelegate.h"
#import "CalcFace.h"

@implementation CalculatorAppDelegate

@synthesize window;

#pragma mark - Life cycle

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    DLog(@"mainScreen: %@", [UIScreen mainScreen]);
    self.window = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
    window.backgroundColor = [UIColor yellowColor];
    window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    CalcFace * calcFace = [[CalcFace alloc] initWithFrame:window.bounds];
    calcFace.backgroundColor = [UIColor grayColor];
    [window addSubview:calcFace];
    [calcFace release];
    [window makeKeyAndVisible];
}

- (void)dealloc
{
    [window release];
    [super dealloc];
}

@end

