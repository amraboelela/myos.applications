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

#import "DivideView.h"
#import <QuartzCore/QuartzCore-private.h>

#define kDotSize           3.0
#define kDotInterSpace     15.0
#define kLineLength        15.0
//#define kLineThickness     4.0

#pragma mark - Static functions

@implementation DivideView

#pragma mark - Life cycle

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Overridden methods
 
- (void)drawRect:(CGRect)rect
{
    DLog(@"rect: %@", NSStringFromCGRect(rect));
    float width = rect.size.width;
    float height = rect.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 1.0);
    CGContextSetLineWidth(context, kDotSize);
    CGContextMoveToPoint(context, (width - kLineLength) / 2.0, height / 2.0);
    CGContextAddLineToPoint(context, (width - kLineLength) / 2.0 + kLineLength, height / 2.0);
    CGContextStrokePath(context);

    CGContextSetRGBFillColor(context, 255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 1.0);
    CGContextFillRect(context, CGRectMake((width - kDotSize) / 2.0,
                                          (height - kDotSize - kDotInterSpace) / 2.0,
                                          kDotSize, kDotSize));
    CGContextFillRect(context, CGRectMake((width - kDotSize) / 2.0,
                                          (height - kDotSize + kDotInterSpace) / 2.0,
                                          kDotSize, kDotSize));
    CGContextRestoreGState(context);
}

@end
