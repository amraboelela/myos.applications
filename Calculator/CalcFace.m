/* CalcFace.m: Front-end of Calculator.app

   Copyright (C) 1999 Free Software Foundation, Inc.

   Author:  Nicola Pero <n.pero@mi.flashnet.it>
   Date: 1999
   
   This file is part of GNUstep.
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA. */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CalcFace.h"

//
// Thanks to Andrew Lindesay for drawing the app icon,
// and for suggestions on the window layout.
//

@implementation CalcFace

@synthesize calcBrain;

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)_frame
{
    //DLog();
    self = [super initWithFrame:_frame];
    if (!self) {
        return nil;
    }
    int i = 0;
    
    //Brain
    self.calcBrain = [[[CalcBrain alloc] init] autorelease];
    [calcBrain setFace:self];
    
    
    // Display
    display = [[UILabel alloc] initWithFrame:CGRectMake(40, 54, 182, 24)];
    display.text = @"Welcome Calculator";
    display.textAlignment = UITextAlignmentRight;
    [self addSubview: display];
    [display release];
    
    
    // Numbers
    buttons[i] = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttons[i].frame = CGRectMake(77, 103, 34, 24);
    //buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(77, 3, 34, 24)];
    [buttons[i] setTitle:@"0" forState:UIControlStateNormal];
    [buttons[i] setTag:i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    for (; i > -1; i--) {
        [self addSubview:buttons[i]];
        //[buttons[i] release];
        DLog(@"buttons[%d]: %@", i, buttons[i]);
    }
    return self;
    
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(114, 3, 34, 24)];
    [buttons[i] setTitle: @"1" forState:UIControlStateNormal];
    [buttons[i] setTag: i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(151, 3, 34, 24)];
    [buttons[i] setTitle: @"2" forState:UIControlStateNormal];
    [buttons[i] setTag: i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    //DLog();
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(188, 3, 34, 24)];
    [buttons[i] setTitle: @"3" forState:UIControlStateNormal];
    [buttons[i] setTag: i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(114, 30, 34, 24)];
    [buttons[i] setTitle: @"4" forState:UIControlStateNormal];
    [buttons[i] setTag: i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(151, 30, 34, 24)];
    [buttons[i] setTitle: @"5" forState:UIControlStateNormal];
    [buttons[i] setTag: 5];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    //DLog();
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(188, 30, 34, 24)];
    [buttons[i] setTitle: @"6" forState:UIControlStateNormal];
    [buttons[i] setTag: 6];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(114, 57, 34, 24)];
    [buttons[i] setTitle: @"7" forState:UIControlStateNormal];
    [buttons[i] setTag: i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(151, 57, 34, 24)];
    [buttons[i] setTitle: @"8" forState:UIControlStateNormal];
    [buttons[i] setTag: i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    //DLog();
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(188, 57, 34, 24)];
    [buttons[i] setTitle: @"9" forState:UIControlStateNormal];
    [buttons[i] setTag: i];
    [buttons[i] addTarget:calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(77, 30, 34, 24)];
    [buttons[i] setTitle: @"." forState:UIControlStateNormal];
    [buttons[i] addTarget:calcBrain action:@selector(decimalSeparator:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(77, 57, 34, 24)];
    [buttons[i] setTitle: @"SQR" forState:UIControlStateNormal];
    [buttons[i] addTarget:calcBrain action:@selector(squareRoot:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(3, 30, 34, 24)];
    [buttons[i] setTitle: @"+" forState:UIControlStateNormal];
    [buttons[i] setTag: addition];
    [buttons[i] addTarget:calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake (40, 30, 34, 24)];
    [buttons[i] setTitle: @"-" forState:UIControlStateNormal];
    [buttons[i] setTag: subtraction];
    [buttons[i] addTarget:calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(3, 57, 34, 24)];
    [buttons[i] setTitle: @"*" forState:UIControlStateNormal];
    [buttons[i] setTag: multiplication];
    [buttons[i] addTarget:calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(40, 57, 34, 24)];
    [buttons[i] setTitle: @"/" forState:UIControlStateNormal];
    [buttons[i] setTag: division];
    [buttons[i] addTarget:calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(3, 84, 34, 24)];
    [buttons[i] setTitle:@"CL" forState:UIControlStateNormal];
    [buttons[i] addTarget:calcBrain action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    i++;
    buttons[i] = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, 71, 24)];
    [buttons[i] setTitle:@"=" forState:UIControlStateNormal];
    [buttons[i] addTarget:calcBrain action:@selector(equal:) forControlEvents:UIControlEventTouchUpInside];
    //DLog();
    for (; i > -1; i--) {
        [self addSubview:buttons[i]];
        [buttons[i] release];
    }
    DLog();
    return self;
}

- (void)dealloc
{
    [calcBrain release];
    [super dealloc];
}

#pragma mark - Public methods

- (void)setDisplayedNumber:(double)aNumber
	     withSeparator:(BOOL)displayDecimalSeparator
	  fractionalDigits:(int)fractionalDigits
{
    //DLog();
    if (displayDecimalSeparator) {
        display.text = [NSString stringWithFormat:
                        [NSString stringWithFormat:
                         @"%%#.%df", fractionalDigits],
                        aNumber];
    } else { // !displayDecimalSeparator
        display.text = [NSString stringWithFormat: @"%.0f", aNumber];
    }
}

- (void)setError
{
    DLog();
    display.text = @"Error";
}

@end


