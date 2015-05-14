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

#import "AnimationGradientsView.h"
//#import <time.h>
#import <stdlib.h>
#import <QuartzCore/CAGradientLayer-private.h>

#define kStartGreenGradientColor    [UIColor colorWithRed:20.0/255. green:152.0/255. blue:36.0/255. alpha:0.0]
#define kMiddleGreenGradientColor   [UIColor colorWithRed:10.0/255. green:96.0/255. blue:12.0/255. alpha:0.5]
#define kEndGreenGradientColor      [UIColor colorWithRed:2.0/255. green:40.0/255. blue:9.0/255. alpha:1.0]

@interface AnimationGradientsView()

//- (void)selectView;
//- (void)unselectView;

@end

@implementation AnimationGradientsView

//@synthesize gradientLayer;
//@synthesize timer;

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame
{
    self = [super initWithFrame:theFrame];
    if (self) {
        //self.backgroundColor = [UIColor blueColor];
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2;
        self.layer.cornerRadius = 10;
        self.opaque = NO;
    }
    return self;
}

- (void)dealloc
{
//    [gradientLayer release];
//    [timer invalidate];
    [super dealloc];
}

#pragma mark - Overridden methods

- (void)drawRect:(CGRect)rect
{
    //DLog(@"rect: %@", NSStringFromCGRect(rect));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);

    NSArray *colors = [NSArray arrayWithObjects:(id)[kStartGreenGradientColor CGColor],
                                                         (id)[kMiddleGreenGradientColor CGColor],
                                                         (id)[kEndGreenGradientColor CGColor], nil];
    CGFloat myRadius = 10;
        //CGFloat borderWidth = 2;
        //CGColorRef borderColor = [[UIColor whiteColor] CGColor];

    // Clipping the view for the gradient
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
 
@end

