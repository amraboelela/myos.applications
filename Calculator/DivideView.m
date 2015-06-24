/*
 Copyright © 2015 myOS Group.
 
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

#import "DivideView.h"
#import <QuartzCore/QuartzCore-private.h>

#define _kPageDotSize           8
#define _kPageDotInterSpace     16

#pragma mark - Static functions

@implementation DivideView

#pragma mark - Life cycle

/*
- (id)initWithFrame:(CGRect)theFrame
{
    if ((self = [super initWithFrame:theFrame])) {
        _dotView = [[UIView alloc] initWithFrame:CGRectMake(0,0,_kPageDotSize,_kPageDotSize)];
        _dotView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_dotView];
        //DLog(@"self.subviews: %@", self.subviews);
    }
    return self;
}*/

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Accessors
/*
- (void)setCurrentPage:(NSInteger)page
{
    //DLog(@"page: %d", page);
    if (page != _currentPage) {
        _currentPage = MIN(MAX(0,page), self.numberOfPages-1);
        [self setNeedsLayout];
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    _CALayerSetNeedsDisplay(_layer);
    _dotView.hidden = (_numberOfPages == 1);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; currentPage: %d; numberOfPages: %d>", [self className], self, _currentPage, _numberOfPages];
}*/

#pragma mark - Overridden methods
 
- (void)drawRect:(CGRect)rect
{
    //DLog(@"_numberOfPages: %d", _numberOfPages);
    //if (_numberOfPages == 1) {
    //    return;
    //}
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //float dotsSize = _kPageDotInterSpace * (_numberOfPages - 1);
    CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 0.5);
    //for (int i = 0; i < _numberOfPages; i++) {
    CGContextFillRect(context, CGRectMake((rect.size.width - _kPageDotSize) / 2.0,
                                          (rect.size.width - _kPageDotSize) / 2.0,
                                          _kPageDotSize, _kPageDotSize));
    //}
    CGContextRestoreGState(context);
    //DLog(@"end");
}

/*
- (void)layoutSubviews
{
    [super layoutSubviews];
    //DLog();
    float dotsSize = _kPageDotInterSpace * (_numberOfPages - 1);
    _dotView.center = CGPointMake((self.frame.size.width - dotsSize) / 2.0 + _currentPage * _kPageDotInterSpace,
                                  self.frame.size.height / 2.0);
}

- (void)_sendActionsForControlEvents:(UIControlEvents)controlEvents withEvent:(UIEvent *)event
{
    [super _sendActionsForControlEvents:controlEvents withEvent:event];
    UITouch *touch = event->_touch;
    if (touch->_phase == UITouchPhaseEnded) {
        //DLog(@"event: %@", event);
        CGPoint point = [touch locationInView:self];
        int oldCurrentPage = _currentPage;
        //DLog(@"_currentPage: %d", _currentPage);
        if (!_defersCurrentPageDisplay) {
            float highlightedDotLoaction = _UIPageControlHighlightedDotLoaction(self);
            if (point.x > highlightedDotLoaction) {
                self.currentPage = _currentPage+1;
            } else {
                self.currentPage = _currentPage-1;
            }
        }
        //DLog(@"_currentPage2: %d", _currentPage);
        if (oldCurrentPage != _currentPage) {
            //DLog();
            [super _sendActionsForControlEvents:UIControlEventValueChanged withEvent:event];
        }
    }
}*/

@end
