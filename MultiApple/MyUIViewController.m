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

#import "MyUIViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kBigAppleFrame CGRectMake(20,20,206,206)

@interface MyUIViewController ()

@property (nonatomic, readwrite, assign, getter=isAppleMoving) BOOL appleMoving;

@end

@implementation MyUIViewController

@synthesize appleView;
@synthesize sillyButton;
@synthesize delegate;
@synthesize appleMoving;

- (void)loadView
{
    //DLog();
    [super loadView];
    //self.view = [[[UIView alloc] initWithFrame:CGRectMake(0,0,320,580)] autorelease];

    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    appleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple.png"]];
    //appleView.layer.anchorPoint = CGPointMake(0,0.5);
    self.appleView.frame = kBigAppleFrame;
    [self.view addSubview:appleView];

    self.sillyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //sillyButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
// FIXME: The title is wrong on the button. Remove the exclamation point!!!!!!11!!
    [sillyButton setTitle:@"Click Me!" forState:UIControlStateNormal];
// .. and then realize you're updating both the Mac and iOS versions of your products at once.
// HUGE WHEN LIKE THE CHOCK

    // Use the user interface idiom to customize the views based upon the platform. In this case it's simply the
    // color of a UI element, but the size and placement of elements will also need to be changed.
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone || UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [sillyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [sillyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }*/

    [sillyButton addTarget:self action:@selector(moveTheApple:) forControlEvents:UIControlEventTouchUpInside];
    sillyButton.frame = CGRectMake(70,400,200,50);
    self.sillyButton.backgroundColor = [UIColor whiteColor];
    self.sillyButton.layer.borderColor = [[UIColor grayColor] CGColor];
    //self.sillyButton.contentScaleFactor = 50;//[UIScreen mainScreen].scale;
    //sillyButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:sillyButton];
}

- (void)viewDidUnload
{
    [appleView release], appleView = nil;
    [sillyButton release], sillyButton = nil;

    [super viewDidUnload];
}

- (void)dealloc
{
    [appleView release], appleView = nil;
    [sillyButton release], sillyButton = nil;
    
    [super dealloc];
}

- (void)appleMoveDidFinish
{
    self.appleMoving = NO;

    //DLog();
    if ([delegate respondsToSelector:@selector(myUiViewControllerDidFinishMovingApple:)]) {
        [delegate myUiViewControllerDidFinishMovingApple:self];
    }
}

#pragma mark - Actions

- (void)moveTheApple:(id)sender
{
    //DLog(@"moveTheApple:");
    if ([delegate respondsToSelector:@selector(myUiViewControllerWillStartMovingApple:)]) {
        [delegate myUiViewControllerWillStartMovingApple:self];
    }
    
    [UIView beginAnimations:@"moveTheApple" context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDidStopSelector:@selector(appleMoveDidFinish)];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    //DLog(@"moveTheApple: 2");
    //DLog(@"appleView.transform: %@", CGAffineTransformDescription(appleView.transform));
    
    //appleView.frame = CGRectMake(0,0,156,156);
    CGFloat perspective = -1.0 / 500.0;
    CGFloat labelPerspective = -1.0 / 250.0;
    CATransform3D t;
    if (CGAffineTransformIsIdentity(sillyButton.transform)) {
        //DLog(@"CGAffineTransformIsIdentity");
        t = CATransform3DIdentity;
        
        //Purple plane: Perform a rotation and then a translation
        t = CATransform3DRotate(t, 55.0f * M_PI / 180.0f, 0, 0, 1);
        t.m34 = perspective;
        //DLog(@"t.m34: %0.3f", t.m34);
        //t = CATransform3DScale(t, 0.99, 1.0, 1.0);
        t = CATransform3DTranslate(t, 70, 400, 170);
        appleView.layer.transform = t;
        //appleView.layer.zPosition = 150;
        //appleView.layer.anchorPoint = CGPointMake(0,0.5);
        
        t = CATransform3DIdentity;
        t = CATransform3DRotate(t, -35.0f * M_PI / 180.0f, 0, 1, 0);
        t.m34 = labelPerspective;
        //sillyButton.titleLabel.layer.transform = t;
        sillyButton.layer.transform = t;
        sillyButton.layer.sublayerTransform = t;
        
        //sillyButton.transform = CGAffineTransformMakeRotation(-70.0f * M_PI / 180.0f);
        //sillyButton.layer.sublayerTransform = CATransform3DMakeRotation(- M_PI / 2.0, 0, 0, 1);
        //sillyButton->_gradientLayer.transform = t;
        //appleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        //DLog(@"appleView.transform: %@", CGAffineTransformDescription(appleView.transform));
        //appleView.center = [self.view convertPoint:self.view.center toView:appleView.superview];
    } else {
        //DLog(@"not CGAffineTransformIsIdentity");
        
         t = CATransform3DIdentity;
        t.m34 = perspective;
        //DLog(@"t.m34: %0.3f", t.m34);
        appleView.layer.transform = t;
        //appleView.layer.zPosition = 0;
        //appleView.frame = CGRectMake(0,0,256,256);
        //appleView.layer.anchorPoint = CGPointMake(0.5,0.5);
        
        //sillyButton.transform = CGAffineTransformIdentity;
        //sillyButton.layer.sublayerTransform = CATransform3DIdentity;
        t = CATransform3DIdentity;
        t.m34 = labelPerspective;
        //sillyButton.titleLabel.layer.transform = t;
        sillyButton.layer.transform = t;
        sillyButton.layer.sublayerTransform = t;
    }
    
    [UIView commitAnimations];
    
    self.appleMoving = YES;
}

@end
