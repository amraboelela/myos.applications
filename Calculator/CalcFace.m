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
#import "DivideView.h"

#define kButtonMargin   2

@implementation CalcFace

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    int i;
    _buttonSize = (frame.size.width - kButtonMargin) / 4.0 - kButtonMargin;
    //DLog(@"_buttonSize: %.2f", _buttonSize);
    float calcWidth = (kButtonMargin + _buttonSize) * 4 - kButtonMargin;
    float calcHeight = (kButtonMargin + _buttonSize) * 7 - kButtonMargin;
    _initialX = (frame.size.width - calcWidth) / 2;
    _initialY = (frame.size.height - calcHeight) / 2;
    _display = [[[UILabel alloc] initWithFrame:CGRectMake(_initialX + (kButtonMargin + _buttonSize), _initialY, kButtonMargin * 2 + _buttonSize * 3, _buttonSize)] autorelease];
    //_display.text = @"gpqPQGaA[]{}";
    //[_display sizeToFit];
    _display.textColor = [UIColor whiteColor];
    _display.backgroundColor = [UIColor blackColor];
    //[self addSubview:_display];
    //[_display release];
    //return self; 

   _display.textAlignment = UITextAlignmentRight;
    _display.backgroundColor = [UIColor blackColor];
    for (i=0; i < 25; i++) {
        _buttons[i] = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttons[i].titleLabel.font = [UIFont systemFontOfSize:28];
    }
    for (i=0; i < 11; i++) {
        _buttons[i].backgroundColor = [UIColor lightGrayColor];
    }
    for (i=11; i < 25; i++) {
        _buttons[i].backgroundColor = [UIColor grayColor];
    }
    for (i=0; i < 10; i++) {
        _buttons[i].tag = i;
        [_buttons[i] setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
    }
    [self setupButton:_buttons[0] atX:1 andY:6];
    for (i=0; i < 3; i++) {
        [self setupButton:_buttons[i+1] atX:i+1 andY:5];
        [self setupButton:_buttons[i+4] atX:i+1 andY:4];
        [self setupButton:_buttons[i+7] atX:i+1 andY:3];
    }

    [_buttons[10] setTitle:@"." forState:UIControlStateNormal];
    [self setupButton:_buttons[10] atX:2 andY:6];
    //_buttons[10].frame = CGRectMake(_initialX + (kButtonMargin + _buttonSize) * 2, _initialY + (kButtonMargin + _buttonSize) * 4, _buttonSize, _buttonSize);
    [_buttons[11] setTitle:@"SQR" forState:UIControlStateNormal];
    [self setupButton:_buttons[11] atX:0 andY:1];
    [_buttons[12] setTitle:@"sin" forState:UIControlStateNormal];
    [self setupButton:_buttons[12] atX:1 andY:1];
    [_buttons[13] setTitle:@"cos" forState:UIControlStateNormal];
    [self setupButton:_buttons[13] atX:2 andY:1];
    [_buttons[14] setTitle:@"tan" forState:UIControlStateNormal];
    [self setupButton:_buttons[14] atX:3 andY:1];
    [_buttons[15] setTitle:@"x " forState:UIControlStateNormal];
    [self setupButton:_buttons[15] atX:0 andY:2];
    _buttons[15].titleLabel.font = [UIFont systemFontOfSize:22];
    UILabel *yLabel = [[[UILabel alloc] init] autorelease];
    yLabel.font = [UIFont systemFontOfSize:12];
    yLabel.textColor = [UIColor whiteColor];
    yLabel.text = @"y";
    [yLabel sizeToFit];
    CGSize xSize = [@"x" sizeWithFont:_buttons[15].titleLabel.font];
    CGSize viewSize = yLabel.frame.size;
    CGRect aFrame = _buttons[15].frame;
    aFrame.origin.x += (aFrame.size.width - xSize.width - viewSize.width) / 2.0 + xSize.width;
    aFrame.origin.y += (aFrame.size.height - xSize.height) / 2.0;
    aFrame.size = viewSize;
    yLabel.frame = aFrame;

    [_buttons[16] setTitle:@"e" forState:UIControlStateNormal];
    [self setupButton:_buttons[16] atX:1 andY:2];
    [_buttons[17] setTitle:@"ln" forState:UIControlStateNormal];
    [self setupButton:_buttons[17] atX:2 andY:2];
    [_buttons[18] setTitle:@"log" forState:UIControlStateNormal];
    [self setupButton:_buttons[18] atX:3 andY:2];
    [_buttons[19] setTitle:@"+" forState:UIControlStateNormal];
    [_buttons[19] setTag:addition];
    [self setupButton:_buttons[19] atX:0 andY:6];
    [_buttons[20] setTitle:@"-" forState:UIControlStateNormal];
    [_buttons[20] setTag:subtraction];
    [self setupButton:_buttons[20] atX:0 andY:5];
    [_buttons[21] setTitle:@"x" forState:UIControlStateNormal];
    [_buttons[21] setTag:multiplication];
    [self setupButton:_buttons[21] atX:0 andY:4];
    [_buttons[22] setTitle:@"" forState:UIControlStateNormal];
    [_buttons[22] setTag:division];
    [self setupButton:_buttons[22] atX:0 andY:3];
    
    DivideView *divideView = [[[DivideView alloc] init] autorelease];
    viewSize = CGSizeMake(40, 40);
    //viewHeight = 40;
    aFrame = _buttons[22].frame;
    //DLog(@"aFrame: %@", NSStringFromCGRect(aFrame));
    aFrame.origin.x += (aFrame.size.width - viewSize.width) / 2.0;
    aFrame.origin.y += (aFrame.size.height - viewSize.height) / 2.0;
    aFrame.size = viewSize;
    //aFrame.size.height = viewSize.height;
    //DLog(@"aFrame 2: %@", NSStringFromCGRect(aFrame));
    divideView.frame = aFrame;
    //DLog(); 
    [_buttons[23] setTitle:@"CL" forState:UIControlStateNormal];
    [self setupButton:_buttons[23] atX:0 andY:0];
    [_buttons[24] setTitle:@"=" forState:UIControlStateNormal];
    [self setupButton:_buttons[24] atX:3 andY:6];
    
    for (i = 0; i < 25; i++) {
        [self addSubview:_buttons[i]];
        //DLog(@"_buttons[%d]: %@", i, _buttons[i]);
    }
    //DLog();
    [self addSubview:_display];
    [self addSubview:yLabel];
    [self addSubview:divideView];
    //[_display release];
    
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
        [_buttons[i] addTarget:aBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_buttons[10] addTarget:aBrain action:@selector(decimalSeparator:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[11] addTarget:aBrain action:@selector(squareRoot:) forControlEvents:UIControlEventTouchUpInside];
/*    [_buttons[12] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[13] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[14] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[15] addTarget:aBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[16] addTarget:aBrain action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[17] addTarget:aBrain action:@selector(equal:) forControlEvents:UIControlEventTouchUpInside];
*/
}

- (void)setDisplayedNumber:(double)aNumber withSeparator:(BOOL)_displayDecimalSeparator fractionalDigits:(int)fractionalDigits
{
    if (_displayDecimalSeparator) {
        _display.text = [NSString stringWithFormat:[NSString stringWithFormat:@"%%#.%df", fractionalDigits], aNumber];
    } else { // !_displayDecimalSeparator
        _display.text = [NSString stringWithFormat: @"%.0f", aNumber];
    }
}

- (void)setError
{
    _display.text = @"Error";
    //[_display setStringValue: @"Error"];
}

/*
- (void)applicationDidFinishLaunching: (NSNotification *)aNotification
{
  [self orderFront: self];
}*/

#pragma mark - Private methods

- (void)setupButton:(UIButton *)button atX:(int)x andY:(int)y
{
    button.frame = CGRectMake(_initialX + (kButtonMargin + _buttonSize) * x, _initialY + (kButtonMargin + _buttonSize) * y, _buttonSize, _buttonSize);
}

@end


