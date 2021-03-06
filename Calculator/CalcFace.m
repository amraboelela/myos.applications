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
#import "SqaureRootView.h"
#import "UIImage+Calculator.h"

#define kButtonMargin   2

#define RGB(r,g,b)		[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define DarkGrayColor		RGB(44,49,52)
#define DarkBlueColor		RGB(0,0,150)

@implementation CalcFace

@synthesize calcBrain=_calcBrain;

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.calcBrain = [[[CalcBrain alloc] init] autorelease];
    [_calcBrain setFace:self];
    
    int i;
    _buttonSize = (frame.size.width - kButtonMargin) / 4.0 - kButtonMargin;
    //DLog(@"_buttonSize: %.2f", _buttonSize);
    float calcWidth = (kButtonMargin + _buttonSize) * 4 - kButtonMargin;
    float calcHeight = (kButtonMargin + _buttonSize) * 7 - kButtonMargin;
    _initialX = (frame.size.width - calcWidth) / 2;
    _initialY = (frame.size.height - calcHeight) / 2;
    _display = [[[UILabel alloc] initWithFrame:CGRectMake(_initialX + (kButtonMargin + _buttonSize), _initialY, kButtonMargin * 2 + _buttonSize * 3, _buttonSize)] autorelease];
    _display.text = @"0 ";
    _display.font = [UIFont systemFontOfSize:28];
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
    for (i=0; i < 10; i++) {
        _buttons[i].backgroundColor = [UIColor lightGrayColor];
        [_buttons[i] setBackgroundImage:[UIImage makeImageFromColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [_buttons[i] addTarget:_calcBrain action:@selector(digit:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (i=11; i < 25; i++) {
        _buttons[i].backgroundColor = [UIColor grayColor];
        [_buttons[i] setBackgroundImage:[UIImage makeImageFromColor:DarkGrayColor] forState:UIControlStateHighlighted];
        //[_buttons[i] addTarget:_calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
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
    _buttons[10].backgroundColor = [UIColor lightGrayColor];
    [_buttons[10] setBackgroundImage:[UIImage makeImageFromColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [_buttons[10] addTarget:_calcBrain action:@selector(decimalSeparator:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttons[11] setTitle:@"" forState:UIControlStateNormal];
    [self setupButton:_buttons[11] atX:0 andY:1];
    SqaureRootView *sqaureRootView = [[[SqaureRootView alloc] init] autorelease];
    CGSize viewSize = CGSizeMake(30, 25);
    //viewHeight = 40;
    CGRect aFrame = _buttons[11].frame;
    //DLog(@"aFrame: %@", NSStringFromCGRect(aFrame));
    aFrame.origin.x += (aFrame.size.width - viewSize.width) / 2.0;
    aFrame.origin.y += (aFrame.size.height - viewSize.height) / 2.0;
    aFrame.size = viewSize;
    //aFrame.size.height = viewSize.height;
    sqaureRootView.frame = aFrame;
    [_buttons[11] addTarget:_calcBrain action:@selector(unaryOpertion:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttons[12] setTitle:@"sin" forState:UIControlStateNormal];
    [self setupButton:_buttons[12] atX:1 andY:1];
    _buttons[12].tag = CalcBrainUnaryOperationSine;
    [_buttons[12] addTarget:_calcBrain action:@selector(unaryOpertion:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[13] setTitle:@"cos" forState:UIControlStateNormal];
    [self setupButton:_buttons[13] atX:2 andY:1];
    _buttons[13].tag = CalcBrainUnaryOperationCosine;
    [_buttons[13] addTarget:_calcBrain action:@selector(unaryOpertion:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[14] setTitle:@"tan" forState:UIControlStateNormal];
    [self setupButton:_buttons[14] atX:3 andY:1];
    _buttons[14].tag = CalcBrainUnaryOperationTangant;
    [_buttons[14] addTarget:_calcBrain action:@selector(unaryOpertion:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[15] setTitle:@"x " forState:UIControlStateNormal];
    [self setupButton:_buttons[15] atX:0 andY:2];
    _buttons[15].tag = CalcBrainOperationPower;
    [_buttons[15] addTarget:_calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    _buttons[15].titleLabel.font = [UIFont systemFontOfSize:22];
    UILabel *yLabel = [[[UILabel alloc] init] autorelease];
    yLabel.font = [UIFont systemFontOfSize:12];
    yLabel.textColor = [UIColor whiteColor];
    yLabel.text = @"y";
    [yLabel sizeToFit];
    CGSize xSize = [@"x" sizeWithFont:_buttons[15].titleLabel.font];
    viewSize = yLabel.frame.size;
    aFrame = _buttons[15].frame;
    aFrame.origin.x += (aFrame.size.width - xSize.width - viewSize.width) / 2.0 + xSize.width;
    aFrame.origin.y += (aFrame.size.height - xSize.height) / 2.0;
    aFrame.size = viewSize;
    yLabel.frame = aFrame;

    [_buttons[16] setTitle:@"e" forState:UIControlStateNormal];
    [self setupButton:_buttons[16] atX:1 andY:2];
    [_buttons[16] addTarget:_calcBrain action:@selector(normalNumber:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[17] setTitle:@"ln" forState:UIControlStateNormal];
    [self setupButton:_buttons[17] atX:2 andY:2];
    _buttons[17].tag = CalcBrainUnaryOperationLn;
    [_buttons[17] addTarget:_calcBrain action:@selector(unaryOpertion:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[18] setTitle:@"log" forState:UIControlStateNormal];
    [self setupButton:_buttons[18] atX:3 andY:2];
    _buttons[18].tag = CalcBrainUnaryOperationLog;
    [_buttons[18] addTarget:_calcBrain action:@selector(unaryOpertion:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[19] setTitle:@"+" forState:UIControlStateNormal];
    _buttons[19].tag = CalcBrainOperationAddition;
    [_buttons[19] addTarget:_calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [self setupButton:_buttons[19] atX:0 andY:6];
    [_buttons[20] setTitle:@"-" forState:UIControlStateNormal];
    _buttons[20].tag = CalcBrainOperationSubtraction;
    [self setupButton:_buttons[20] atX:0 andY:5];
    [_buttons[20] addTarget:_calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[21] setTitle:@"x" forState:UIControlStateNormal];
    _buttons[21].tag = CalcBrainOperationMultiplication;
    [self setupButton:_buttons[21] atX:0 andY:4];
    [_buttons[21] addTarget:_calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[22] setTitle:@"" forState:UIControlStateNormal];
    _buttons[22].tag = CalcBrainOperationDivision;
    [self setupButton:_buttons[22] atX:0 andY:3];
    [_buttons[22] addTarget:_calcBrain action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    
    DivideView *divideView = [[[DivideView alloc] init] autorelease];
    viewSize = CGSizeMake(40, 40);
    //viewHeight = 40;
    aFrame = _buttons[22].frame;
    aFrame.origin.x += (aFrame.size.width - viewSize.width) / 2.0;
    aFrame.origin.y += (aFrame.size.height - viewSize.height) / 2.0;
    aFrame.size = viewSize;
    //aFrame.size.height = viewSize.height;
    divideView.frame = aFrame;
    [_buttons[23] setTitle:@"CL" forState:UIControlStateNormal];
    [self setupButton:_buttons[23] atX:0 andY:0];
    [_buttons[23] addTarget:_calcBrain action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [_buttons[24] setTitle:@"=" forState:UIControlStateNormal];
    _buttons[24].backgroundColor = [UIColor blueColor];
    [_buttons[24] setBackgroundImage:[UIImage makeImageFromColor:DarkBlueColor] forState:UIControlStateHighlighted];
    [self setupButton:_buttons[24] atX:3 andY:6];
    [_buttons[24] addTarget:_calcBrain action:@selector(equal:) forControlEvents:UIControlEventTouchUpInside];
    
    for (i = 0; i < 25; i++) {
        [self addSubview:_buttons[i]];
        //DLog(@"_buttons[%d]: %@", i, _buttons[i]);
    }
    [self addSubview:_display];
    [self addSubview:sqaureRootView];
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

- (void)setDisplayedNumber:(double)aNumber withSeparator:(BOOL)_displayDecimalSeparator fractionalDigits:(int)fractionalDigits
{
    if (_displayDecimalSeparator) {
        _display.text = [NSString stringWithFormat:[NSString stringWithFormat:@"%%#.%df ", fractionalDigits], aNumber];
        if (_display.text.length > 14) {
            _display.text = [_display.text substringToIndex:14];
            _display.text = [NSString stringWithFormat:@"%@ ", _display.text];
        }
    } else { // !_displayDecimalSeparator
        _display.text = [NSString stringWithFormat: @"%.0f ", aNumber];
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


