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

#import "CircleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CircleView

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame
{
    self = [super initWithFrame:theFrame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        self.layer.cornerRadius = theFrame.size.height / 2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - Overridden methods

@end
