//
//  IGCloseButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGCloseButton.h"

#define flBtnSide           54.0f
#define flCrossSide         14.0f
#define flLineWidth         5.0f

@implementation IGCloseButton

- (id)init{
    if (self = [super initWithFrame:(CGRectMake(0.0f, 0.0f, flBtnSide, flBtnSide))]) {
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetLineWidth(context, flLineWidth);
    
    CGFloat margin = (flBtnSide - flCrossSide) / 2;
    
    CGContextMoveToPoint(context, margin, margin);
    CGContextAddLineToPoint(context, margin + flCrossSide, margin + flCrossSide);
    
    CGContextMoveToPoint(context, margin + flCrossSide, margin);
    CGContextAddLineToPoint(context, margin, margin + flCrossSide);
    
    CGContextStrokePath(context);
}

@end
