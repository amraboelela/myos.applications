/* CalcBrain.m: Brain of Calculator.app

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

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include "CalcBrain.h"
#include "CalcFace.h"
#include <math.h>

@implementation CalcBrain

#pragma mark - Life cycle

- (id)init
{
    [super init];
    _result = 0;
    _enteredNumber = 0;
    _operation = none;
    _fractionalDigits = 0;
    _decimalSeparator = NO;
    _editing = YES;
    _face = nil;
    return self;
}

- (void)dealloc
{
    if (_face) {
        [_face release];
    }
    [super dealloc];
}

#pragma mark - Accessors

// Set the corresponding face
- (void)setFace:(CalcFace *)aFace
{
    DLog();
    _face = [aFace retain];
    [_face setDisplayedNumber:_enteredNumber withSeparator:_decimalSeparator fractionalDigits:_fractionalDigits];
}

// The various buttons 
- (void)clear:(id)sender
{
    DLog();
    _result = 0;
    _enteredNumber = 0;
    _operation = none;
    _fractionalDigits = 0;
    _decimalSeparator = NO;
    _editing = YES;
    [_face setDisplayedNumber:0 withSeparator:NO fractionalDigits:0];
}

- (void)equal:(id)sender
{
    DLog();
    switch (_operation) {
        case none:
            _result = _enteredNumber;
            _enteredNumber = 0;
            _decimalSeparator = NO;
            _fractionalDigits = 0;
            return;
            break;
        case addition:
            _result = _result + _enteredNumber;
            break;
        case subtraction:
            _result = _result - _enteredNumber;
            break;
        case multiplication:
            _result = _result * _enteredNumber;
            break;
        case division:
            if (_enteredNumber == 0) {
                [self error];
                return;
            } else {
                _result = _result / _enteredNumber;
            }
            break;
    }
    [_face setDisplayedNumber:_result
               withSeparator:(ceil(_result) != _result)
            fractionalDigits:7];
    _enteredNumber = _result;
    _operation = none;
    _editing = NO;
}

- (void)digit:(id)sender
{
    //DLog();
    //DLog(@"sender: %@", sender);
    if (!_editing) {
        _enteredNumber = 0;
        _decimalSeparator = NO;
        _fractionalDigits = 0;
        _editing = YES;
    }
    if (_decimalSeparator) {
        _enteredNumber = _enteredNumber
        + ([sender tag] * pow (0.1, 1+_fractionalDigits));
        _fractionalDigits++;
    } else {
        _enteredNumber = _enteredNumber * 10 + ([sender tag]);
        // Check overflow
        if (_enteredNumber > pow (10, 15)) {
            [self error];
            return;
        }
    }
    [_face setDisplayedNumber:_enteredNumber withSeparator:_decimalSeparator fractionalDigits:_fractionalDigits];
}

- (void)decimalSeparator:(id)sender
{
    DLog();
    if (!_editing) {
        _enteredNumber = 0;
        _decimalSeparator = NO;
        _fractionalDigits = 0;
        _editing = YES;
    }
    if (!_decimalSeparator) {
        _decimalSeparator = YES;
        [_face setDisplayedNumber:_enteredNumber withSeparator:YES fractionalDigits:0];
    }
}

- (void)operation:(id)sender
{
    DLog();
    if (_operation == none) {
        _result = _enteredNumber;
        _enteredNumber = 0;
        _decimalSeparator = NO;
        _fractionalDigits = 0;
        _operation = [sender tag];
    } else { // operation
        [self equal:nil];
        [self operation:sender];
    }
}

- (void)squareRoot:(id)sender
{
    //DLog();
    if (_operation == none) {
        DLog(@"_enteredNumber: %.2f", _enteredNumber);
        _result = sqrt(_enteredNumber);
        DLog(@"_result: %.2f", _result);
        [_face setDisplayedNumber:_result withSeparator:(ceil(_result)!=_result) fractionalDigits:7];
        _enteredNumber = _result;
        _editing = NO;
        _operation = none;
    } else { // operation
        DLog();
        [self equal:nil];
        [self squareRoot:sender];
    }
}

- (void)error
{
    DLog();
    _result = 0;
    _enteredNumber = 0;
    _operation = none;
    _fractionalDigits = 0;
    _decimalSeparator = NO;
    _editing = YES;
    [_face setError];
}

@end

