/*
 * Copyright (c) 2012. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

#define kParentFrameSize 310

@interface MyImageView : UIView
{
    UIImageView *imageView;
    CGPoint firstLocationInView;
    CGPoint firstImageLocation;
    NSTimeInterval previousTimestamp;
}

@property (nonatomic, retain) UIImageView *imageView;

@end

