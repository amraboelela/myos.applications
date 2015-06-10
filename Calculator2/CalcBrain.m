/* CalcBrain.m: Brain of Calculator.app

   Copyright (C) 1999 Free Software Foundation, Inc.

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
#import "CalcBrain.h"
#import "CalcFace.h"
#import <math.h>

@implementation CalcBrain

#pragma mark - Life cycle

- (id)init
{
    [super init];
    DLog();
    result = 0;
    enteredNumber = 0;
    operation = none;
    fractionalDigits = 0;
    decimalSeparator = NO;
    editing = YES;
    face = nil;
    DLog();
    return self;
}

- (void)dealloc
{
    DLog();
    //if (face) {
    [face release];
    //}
    [super dealloc];
}

// Set the corresponding face
- (void)setFace:(CalcFace *)aFace
{
    DLog();
    face = [aFace retain];
    [face setDisplayedNumber: enteredNumber withSeparator: decimalSeparator
            fractionalDigits: fractionalDigits];
}

// The various buttons 
- (void)clear:(id)sender
{
    DLog();
    result = 0;
    enteredNumber = 0;
    operation = none;
    fractionalDigits = 0;
    decimalSeparator = NO;
    editing = YES;
    [face setDisplayedNumber: 0 withSeparator: NO fractionalDigits: 0];
}

- (void)equal:(id)sender
{
    DLog();
    switch (operation) {
        case none:
            result = enteredNumber;
            enteredNumber = 0;
            decimalSeparator = NO;
            fractionalDigits = 0;
            return;
            break;
        case addition:
            result = result + enteredNumber;
            break;
        case subtraction:
            result = result - enteredNumber;
            break;
        case multiplication:
            result = result * enteredNumber;
            break;
        case division:
            if (enteredNumber == 0)
            {
                [self error];
                return;
            }
            else
                result = result / enteredNumber;
            break;
    }
    [face setDisplayedNumber: result 
               withSeparator: (ceil(result) != result)      
            fractionalDigits: 7];
    enteredNumber = result;
    operation = none;
    editing = NO;
}

- (void)digit:(id)sender
{
    DLog();
    if (!editing) {
        enteredNumber = 0;
        decimalSeparator = NO;
        fractionalDigits = 0;
        editing = YES;
    }
    if (decimalSeparator) {
        enteredNumber = enteredNumber
        + ([sender tag] * pow (0.1, 1+fractionalDigits));
        fractionalDigits++;
    } else {
        enteredNumber = enteredNumber * 10 + ([sender tag]);
        // Check overflow
        if (enteredNumber > pow (10, 15)) {
            [self error];
            return;
        }
    }
    [face setDisplayedNumber: enteredNumber withSeparator: decimalSeparator
            fractionalDigits: fractionalDigits];
}

- (void)decimalSeparator:(id)sender
{
    DLog();
    if (!editing) {
        enteredNumber = 0;
        decimalSeparator = NO;
        fractionalDigits = 0;
        editing = YES;
    }
    if (!decimalSeparator) {
        decimalSeparator = YES;
        [face setDisplayedNumber: enteredNumber withSeparator: YES
                fractionalDigits: 0];
    }
}

- (void)operation:(id)sender
{
    DLog();
    if (operation == none) {
        result = enteredNumber;
        enteredNumber = 0;
        decimalSeparator = NO;
        fractionalDigits = 0;
        operation = [sender tag];
    } else { // operation
        [self equal: nil];
        [self operation: sender];
    }
}

- (void)squareRoot:(id)sender
{
    DLog();
    if (operation == none) {
        result = sqrt (enteredNumber);
        [face setDisplayedNumber: result
                   withSeparator: (ceil(result) != result)
                fractionalDigits: 7];
        enteredNumber = result;
        editing = NO;
        operation = none;
    } else { // operation
        [self equal: nil];
        [self squareRoot: sender];
    }
}

- (void)error
{
    DLog();
    result = 0;
    enteredNumber = 0;
    operation = none;
    fractionalDigits = 0;
    decimalSeparator = NO;
    editing = YES;
    [face setError];
}

@end

