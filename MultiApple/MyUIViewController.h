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

@class MyUIViewController;

@protocol MyUIViewControllerDelegate <NSObject>

@optional

- (void)myUiViewControllerWillStartMovingApple:(MyUIViewController *)viewController;
- (void)myUiViewControllerDidFinishMovingApple:(MyUIViewController *)viewController;

@end

@interface MyUIViewController : UIViewController
{
    id<MyUIViewControllerDelegate> delegate;
    UIImageView *appleView;
    UIButton *sillyButton;
    BOOL appleMoving;
}

@property (nonatomic, retain) UIImageView *appleView;
@property (nonatomic, retain) UIButton *sillyButton;

@property (nonatomic, assign) id<MyUIViewControllerDelegate> delegate;
@property (nonatomic, readonly, assign, getter=isAppleMoving) BOOL appleMoving;

- (void)moveTheApple:(id)sender;

@end
