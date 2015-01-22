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

#import "RRSolidView.h"

@implementation RRSolidView

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame
{
    DLog();
    self = [super initWithFrame:theFrame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        self.backgroundColor = [UIColor redColor];//[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
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
