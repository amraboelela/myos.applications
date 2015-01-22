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
//#import "TemplateView.h"

@implementation AppDelegate

@synthesize window=_window;

#pragma mark - Life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:frame] autorelease];
    self.window.backgroundColor = [UIColor yellowColor];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10,40,160,30)] autorelease];
    //label.contentScaleFactor = [[UIScreen mainScreen] scale];
    label.text = @"Test text drawing 12";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:12];
    [self.window addSubview:label];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(10,80,160,30)] autorelease];
    label.text = @"Test text drawing 20";
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = UITextAlignmentRight;
    label.font = [UIFont boldSystemFontOfSize:18];
    [self.window addSubview:label];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(10,120,160,30)] autorelease];
    //label.contentScaleFactor = [[UIScreen mainScreen] scale];
    label.text = @"Test text drawing 20";
    label.textAlignment = UITextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16];
    [self.window addSubview:label];
    /*
     label = [[[UILabel alloc] initWithFrame:CGRectMake(10,160,160,30)] autorelease];
     //label.contentScaleFactor = [[UIScreen mainScreen] scale];
     label.text = @"Test text drawing 20";
     label.textAlignment = UITextAlignmentLeft;
     label.font = [UIFont systemFontOfSize:16];
     [window addSubview:label];*/
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(180,40,130,30)] autorelease];
    label.text = @"Test text drawing 12";
    label.backgroundColor = [UIColor greenColor];
    label.textColor = [UIColor redColor];
    label.lineBreakMode = UILineBreakModeMiddleTruncation;
    [self.window addSubview:label];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(180,80,130,30)] autorelease];
    //label.contentScaleFactor = [[UIScreen mainScreen] scale];
    label.text = @"Test text drawing 20";
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor grayColor];
    label.lineBreakMode = UILineBreakModeHeadTruncation;
    label.font = [UIFont systemFontOfSize:18];
    [self.window addSubview:label];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(180,120,130,30)] autorelease];
    label.text = @"Test text drawing 20";
    label.backgroundColor = [UIColor brownColor];
    label.lineBreakMode = UILineBreakModeTailTruncation;
    label.font = [UIFont fontWithName:@"DejaVu Serif-Bold" size:18];
    [self.window addSubview:label];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark - Delegates

@end
