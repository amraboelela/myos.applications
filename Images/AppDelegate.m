/*
 * Copyright (c) 2012. All rights reserved.
 *
 */

#import "AppDelegate.h"
#import "ImagesView.h"

@implementation AppDelegate

@synthesize window=_window;

#pragma mark - Life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:frame] autorelease];
    self.window.backgroundColor = [UIColor yellowColor];
    float width = 300;
    float height = 300;
    float x = (frame.size.width - width) / 2.0;
    float y = (frame.size.height - height) / 2.0;
    ImagesView *images = [[[ImagesView alloc] initWithFrame:CGRectMake(x,y,width,height)] autorelease];
    [self.window addSubview:images];
    //DLog(@"images: %@", images);
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

