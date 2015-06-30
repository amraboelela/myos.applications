/*
 Copyright © 2015 myOS Group.
 
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

#import "SqaureRootView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define kLineLength        15.0

#pragma mark - Static functions

@implementation SqaureRootView

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        //DLog();
        self.contentScaleFactor = [UIScreen mainScreen].scale;
    }
    //DLog(@"self: %@", self);
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Overridden methods

- (void)drawRect:(CGRect)rect
{
    //DLog(@"rect: %@", NSStringFromCGRect(rect));
    float width = rect.size.width;
    float height = rect.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 1.0);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, width * 0.85, 0);
    CGContextAddLineToPoint(context, width / 2.0, 0);
    CGContextAddLineToPoint(context, width / 3.0, height);
    CGContextAddLineToPoint(context, width * 0.2, height * 0.6);
    CGContextAddLineToPoint(context, width * 0.2 - 2, height * 0.6 + 2);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

@end
