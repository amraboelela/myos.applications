/*
 * Copyright (c) 2012. All rights reserved.
 *
 */

#import "AppDelegate.h"
#import "ColorSpaceView.h"

@implementation AppDelegate

@synthesize window=_window;

#pragma mark - Life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //DLog();
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:frame] autorelease];
    self.window.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];//[UIColor blueColor];
    float width = 300;
    float height = 300;
    float x = (frame.size.width - width) / 2.0;
    float y = (frame.size.height - height) / 2.0;
    ColorSpaceView *colorspace = [[[ColorSpaceView alloc] initWithFrame:CGRectMake(x,y,width,height)] autorelease];
    [self.window addSubview:colorspace];
    //DLog(@"colorspace: %@", colorspace);
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //DLog();
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end

