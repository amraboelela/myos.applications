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

#define kBigAppleFrame CGRectMake(100,150,256,256)

@implementation AppDelegate

@synthesize window;
@synthesize appleView;
@synthesize sillyButton;

#pragma mark - Life cycle

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    //DLog(@"mainScreen: %@", [UIScreen mainScreen]);
    self.window = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
    window.backgroundColor = [UIColor yellowColor];
    window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    //DLog(@"window: %@", window);
    self.appleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple.png"]] autorelease];
    self.appleView.frame = kBigAppleFrame;
    [window addSubview:appleView];

    //DLog(@"appleView: %@", appleView);
    self.sillyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.sillyButton.frame = CGRectMake(70,420,200,50);
    
    self.sillyButton.backgroundColor = [UIColor whiteColor];
    self.sillyButton.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [sillyButton setTitle:@"Click Me!" forState:UIControlStateNormal];
    [sillyButton addTarget:self action:@selector(moveTheApple:) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:sillyButton];
    
    DLog(@"sillyButton: %@", sillyButton);
    [window makeKeyAndVisible];
}

- (void)dealloc
{
    [window release];
    [appleView release];
    [sillyButton release];
    [super dealloc];
}

#pragma mark - Actions

- (void)moveTheApple:(id)sender
{
    [UIView beginAnimations:@"moveTheApple" context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (CGAffineTransformIsIdentity(appleView.transform)) {
        appleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        appleView.center = [window convertPoint:window.center toView:appleView.superview];
    } else {
        appleView.transform = CGAffineTransformIdentity;
        if (appleView.frame.origin.x == 0) {
            appleView.frame = kBigAppleFrame;
        } else {
            appleView.frame = CGRectMake(0,10,256,256);
        }
    }
    [UIView commitAnimations];
}

@end

