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

#import "AppleController.h"

@interface AppleController ()

@property (nonatomic, retain) MyUIViewController *myUiViewController;

@end


@implementation AppleController

@synthesize delegate;
@synthesize myUiViewController;
@synthesize navigationController;

- (id)init
{
    if ((self=[super init])) {
        // In this example, both the Mac and iOS versions of the product use the same view controller. If
        // you want to use different controllers that are specific to a platform, just move the instance
        // variable and instantiation to a subclass. The same goes with delegation. The thing you won't want
        // to mess with are the actions and state management: they work best when centralized in this base
        // class.
        myUiViewController = [[MyUIViewController alloc] init];
        myUiViewController.delegate = self;
        
        navigationController = [[UINavigationController alloc] initWithRootViewController:myUiViewController];
        myUiViewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStylePlain target:self action:@selector(moveTheApple)] autorelease];
    }
    return self;
}

- (void)dealloc
{
    myUiViewController.delegate = nil;
    [myUiViewController	release], myUiViewController = nil;
    [navigationController release], navigationController = nil;
    [super dealloc];
}

#pragma mark - Accessors

// return the view controller that acts as the root for the application
- (UIViewController *)viewController
{
    // override in subclass
    return navigationController;
}

#pragma mark - Delegates

// forward delegate callbacks from the view controller
- (void)myUiViewControllerWillStartMovingApple:(MyUIViewController *)viewController
{
    // subclasses can override
    /*if ([delegate respondsToSelector:@selector(appleControllerWillStartMovingApple:)]) {
        [delegate appleControllerWillStartMovingApple:self];
    }*/
    [myUiViewController.navigationItem.rightBarButtonItem setEnabled:NO];
}

- (void)myUiViewControllerDidFinishMovingApple:(MyUIViewController *)viewController
{
    // subclasses can override
    /*if ([delegate respondsToSelector:@selector(appleControllerDidFinishMovingApple:)]) {
        [delegate appleControllerDidFinishMovingApple:self];
    }*/
    [myUiViewController.navigationItem.rightBarButtonItem setEnabled:YES];
}

#pragma mark - Public methods

// pass actions and state queries to the view controller
- (BOOL)canMoveApple
{
    return (![myUiViewController isAppleMoving]);
}

- (void)moveTheApple
{
    [myUiViewController moveTheApple:self];
}

@end
