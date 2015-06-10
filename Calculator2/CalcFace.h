/* CalcFace.h: Frontend of Calculator.app

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

#import "CalcTypes.h"
#import "CalcBrain.h"

@class CalcBrain;

@interface CalcFace: UIView {
    UIButton *buttons[18];
    UILabel *display;
    CalcBrain *calcBrain;
}

@property (retain) CalcBrain *calcBrain;

// Display a number
- (void)setDisplayedNumber:(double)aNumber
             withSeparator:(BOOL)displayDecimalSeparator
          fractionalDigits:(int)fractionalDigits;
// Tell the user a calculation error occurred
- (void)setError;
@end

