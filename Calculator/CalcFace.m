/* CalcFace.m: Front-end of Calculator.app

   Copyright (C) 1999 - 2015 Free Software Foundation, Inc.

   Author:  Nicola Pero <n.pero@mi.flashnet.it>
   Date: 1999
   Modified by: Amr Aboelela <amraboelela@gmail.com>
   Date: Jun 2015
 
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

//#define buttonSize    45
//#define buttonSize   45
#define kButtonMargin   3
//#define initialX       50
//#define initialY       100

//
// Thanks to Andrew Lindesay for drawing the app icon,
// and for suggestions on the window layout.
//

@implementation CalcFace

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    int i;
    float initialX;
    float buttonSize;
    float initialY;
    buttonSize = (frame.size.width - kButtonMargin) / 6.0 - kButtonMargin;
    //DLog(@"buttonSize: %.2f", buttonSize);
    float calcWidth = (kButtonMargin + buttonSize) * 6 - kButtonMargin;
    float calcHeight = (kButtonMargin + buttonSize) * 4 - kButtonMargin;
    initialX = (frame.size.width - calcWidth) / 2;
    initialY = (frame.size.height - calcHeight) / 2;
    display = [[UILabel alloc] initWithFrame:CGRectMake(initialX + (kButtonMargin + buttonSize) * 1, initialY + (kButtonMargin + buttonSize) * 3, (kButtonMargin + buttonSize) * 4 + buttonSize, buttonSize)];
    display.textAlignment = UITextAlignmentRight;
    display.backgroundColor = [UIColor blackColor];
    for (i=0; i < 18; i++) {
        buttons[i] = [UIButton buttonWithType:UIButtonTypeCustom];
        buttons[i].backgroundColor = [UIColor lightGrayColor];
    }
    for (i=0; i < 10; i++) {
        buttons[i].tag = i;
        [buttons[i] setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
    }
  
 
    buttons[0].frame = CGRectMake(initialX + (kButtonMargin + buttonSize) * 2, initialY, buttonSize, buttonSize);
    /*for (i=0; i < 10; i++) {
        buttons[i].frame = CGRectMake(initialX + (kButtonMargin + buttonSize) * (i + 2), initialY, buttonSize, buttonSize);
    }*/
    //[buttons[0] setTitle:@"/" forState:UIControlStateNormal];
    //DLog(@"buttons[0]: %@", buttons[0]);

    //DLog();    
    for (i=0; i < 3; i++) {
        buttons[i+1].frame = CGRectMake(initialX + (kButtonMargin + buttonSize) * (i + 3), initialY, buttonSize, buttonSize);
        buttons[i+4].frame = CGRectMake(initialX + (kButtonMargin + buttonSize) * (i + 3), initialY + kButtonMargin + buttonSize, buttonSize, buttonSize);
        buttons[i+7].frame = CGRectMake(initialX + (kButtonMargin + buttonSize) * (i + 3), initialY + (kButtonMargin + buttonSize) * 2, buttonSize, buttonSize);
    }

    [buttons[10] setTitle:@"." forState:UIControlStateNormal];
    [buttons[11] setTitle:@"SQR" forState:UIControlStateNormal];
    [buttons[12] setTitle:@"+" forState:UIControlStateNormal];
    [buttons[12] setTag:addition];
    [buttons[13] setTitle:@"-" forState:UIControlStateNormal];
    [buttons[13] setTag:subtraction];
    [buttons[14] setTitle:@"*" forState:UIControlStateNormal];
    [buttons[14] setTag:multiplication];
    [buttons[15] setTitle:@"/" forState:UIControlStateNormal];
    [buttons[15] setTag:division];
     for (i=0; i < 2; i++) {
        buttons[i+10].frame = CGRectMake(initialX, initialY + (kButtonMargin + buttonSize) * (i + 1), buttonSize, buttonSize);
        buttons[i+12].frame = CGRectMake(initialX + (kButtonMargin + buttonSize) * (i + 1), initialY + kButtonMargin + buttonSize, buttonSize, buttonSize);
        buttons[i+14].frame = CGRectMake(initialX + (kButtonMargin + buttonSize) * (i + 1), initialY + (kButtonMargin + buttonSize) * 2, buttonSize, buttonSize);
    }
    [buttons[16] setTitle:@"CL" forState:UIControlStateNormal];
    buttons[16].frame = CGRectMake(initialX, initialY + (kButtonMargin + buttonSize) * 3, buttonSize, buttonSize);
    [buttons[17] setTitle:@"=" forState:UIControlStateNormal];
    buttons[17].frame = CGRectMake(initialX, initialY, kButtonMargin + buttonSize * 2, buttonSize);
    
    for (i = 0; i < 18; i++) {
        [self addSubview:buttons[i]];
    }
    [self addSubview:display];
    [display release];
    
    //DLog();    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Accessors

- (void)setBrain:(CalcBrain *)aBrain
{
    DLog(@"aBrain: %@", aBrain);
    for (int i = 0; i < 10; i++) {
        [buttons[i] addTarget:aBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    }
    [buttons[10] addTarget:aBrain action:@selector(decimalSeparator:) forControlEvents:UIControlEventTouchUpInside];
    [buttons[11] addTarget:aBrain action:@selector(squareRoot:) forControlEvents:UIControlEventTouchUpInside];
/*    [buttons[12] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [buttons[13] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [buttons[14] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [buttons[15] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [buttons[16] addTarget:aBrain action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [buttons[17] addTarget:aBrain action:@selector(equal:) forControlEvents:UIControlEventTouchUpInside];
*/
}

- (void)setDisplayedNumber:(double)aNumber withSeparator:(BOOL)displayDecimalSeparator fractionalDigits:(int)fractionalDigits
{
    if (displayDecimalSeparator) {
        display.text = [NSString stringWithFormat:[NSString stringWithFormat:@"%%#.%df", fractionalDigits], aNumber];
    } else { // !displayDecimalSeparator
        display.text = [NSString stringWithFormat: @"%.0f", aNumber];
    }
}

- (void)setError
{
    display.text = @"Error";
    //[display setStringValue: @"Error"];
}

/*
- (void)applicationDidFinishLaunching: (NSNotification *)aNotification
{
  [self orderFront: self];
}*/

@end


