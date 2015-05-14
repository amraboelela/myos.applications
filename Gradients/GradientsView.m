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

#import "GradientsView.h"
#import <time.h>
#import <stdlib.h>
#import <QuartzCore/CAGradientLayer-private.h>

#define kStartGreenGradientColor    [UIColor colorWithRed:20.0/255. green:152.0/255. blue:36.0/255. alpha:0.0]
#define kMiddleGreenGradientColor   [UIColor colorWithRed:10.0/255. green:96.0/255. blue:12.0/255. alpha:0.5]
#define kEndGreenGradientColor      [UIColor colorWithRed:2.0/255. green:40.0/255. blue:9.0/255. alpha:1.0]

@interface GradientsView()

- (void)selectView;
- (void)unselectView;

@end

@implementation GradientsView

@synthesize gradientLayer=_gradientLayer;
@synthesize timer=_timer;

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame
{
    self = [super initWithFrame:theFrame];
    if (self) {
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2;
        self.layer.cornerRadius = 10;
        self.opaque = NO;
        self.gradientLayer = [CAGradientLayer layer];

        // display gradienLayer
        self.gradientLayer.frame = self.bounds;
        self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[_kStartBlueGradientColor CGColor],
                                                         (id)[_kMiddleBlueGradientColor CGColor],
                                                         (id)[_kEndBlueGradientColor CGColor], nil];
        self.gradientLayer.cornerRadius = 10;
        self.gradientLayer.borderWidth = 2;
        self.gradientLayer.borderColor = [[UIColor whiteColor] CGColor];

        long selfPointer = (long)self;
        //int r = selfPointer % 5 + 1;
        int r = (rand()/2 + selfPointer) % 3 + 2;
        //DLog(@"r: %d", r);
        [NSTimer scheduledTimerWithTimeInterval:r target:self selector:@selector(selectView) userInfo:nil repeats:YES];
        NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:r+1];
        self.timer = [[[NSTimer alloc] initWithFireDate:fireDate
                                               interval:r
                                                 target:self
                                               selector:@selector(unselectView)
                                               userInfo:nil
                                                repeats:YES] autorelease];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)dealloc
{
    [_gradientLayer release];
    [_timer invalidate];
    [super dealloc];
}

#pragma mark - Overridden methods

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);

    NSArray *colors = [NSArray arrayWithObjects:(id)[kStartGreenGradientColor CGColor],
                                                         (id)[kMiddleGreenGradientColor CGColor],
                                                         (id)[kEndGreenGradientColor CGColor], nil];
    CGFloat myRadius = 10;

    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, rect.size.width - myRadius, myRadius, myRadius, PI*1.5, 0 , NO);
    CGContextAddArc(ctx, rect.size.width - myRadius, rect.size.height - myRadius, myRadius, 0, PI/2 , NO);
    CGContextAddArc(ctx, myRadius, rect.size.height - myRadius, myRadius, PI/2, PI, NO);
    CGContextAddArc(ctx, myRadius, myRadius, myRadius, PI, PI*1.5, NO);
    CGContextClip(ctx);


    // Drawing the gradient
    size_t numberOfLocations = [colors count];
    CGFloat *gLocations = (CGFloat *)malloc(numberOfLocations * sizeof(CGFloat));
    CGFloat *components = (CGFloat *)malloc(4 * numberOfLocations * sizeof(CGFloat));
    for (int i=0; i<numberOfLocations; i++) {
        gLocations[i] = 1.0/(numberOfLocations-1)*i;
        CGColor *aColor = [colors objectAtIndex:i];
        const CGFloat *aColorComponents = CGColorGetComponents(aColor);
        components[i*4] = aColorComponents[0];
        components[i*4+1] = aColorComponents[1];
        components[i*4+2] = aColorComponents[2];
        components[i*4+3] = aColorComponents[3];
    }
    CGColorSpaceRef myColorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorSpace, components, gLocations, numberOfLocations);

    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0.0;
    myStartPoint.y = 0.0;
    myEndPoint.x = 0.0;
    myEndPoint.y = rect.size.height;
    CGContextDrawLinearGradient(ctx, myGradient, myStartPoint, myEndPoint, 0);
    free(gLocations);
    free(components);
    CGColorSpaceRelease(myColorSpace);
    CGGradientRelease(myGradient);
    CGContextRestoreGState(ctx);
}

- (void)selectView
{
    //DLog();
//    DLog(@"memory usage: %lu page", CFGetMemoryUsage());
    [self.layer insertSublayer:self.gradientLayer atIndex:0];
}

- (void)unselectView
{
    //DLog();
    [self.gradientLayer removeFromSuperlayer];
}
 
@end
