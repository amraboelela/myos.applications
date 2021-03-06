/*
 Copyright © 2014 myOS Group.
 
 This application is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later version.
 
 This application is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 Lesser General Public License for more details.
 
 Contributor(s):
 Amr Aboelela <amraboelela@gmail.com>
 */

#import "RectangleView.h"

@implementation RectangleView

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame
{
    self = [super initWithFrame:theFrame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

#pragma mark - Overridden methods
/*
- (void)drawRect:(CGRect)rect
{
    [[UIColor redColor] set];
    [[UIColor redColor] setFill];
    NSRectFill(NSMakeRect(0,0,200,100));
}*/

@end
