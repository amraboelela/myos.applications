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

#import <UIKit/UIKit.h>
#import "MyUIViewController.h"

@class AppleController;

@protocol AppleControllerDelegate <NSObject>

@optional

- (void)appleControllerWillStartMovingApple:(AppleController *)controller;
- (void)appleControllerDidFinishMovingApple:(AppleController *)controller;

@end

@interface AppleController : NSObject <MyUIViewControllerDelegate>
{
    id<AppleControllerDelegate> delegate;
    MyUIViewController *myUiViewController;
    UINavigationController *navigationController;
}

@property (nonatomic, assign) id<AppleControllerDelegate> delegate;
@property (nonatomic, retain) UINavigationController *navigationController;

- (UIViewController *)viewController;

- (BOOL)canMoveApple;
- (void)moveTheApple;

@end

