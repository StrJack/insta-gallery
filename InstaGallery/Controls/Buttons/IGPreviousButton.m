//
//  IGPreviousButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/23/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGPreviousButton.h"

#define flBtnSide           54.0f
#define flDrawSide          18.0f
#define flLineWidth         5.0f

@implementation IGPreviousButton

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
    
    CGFloat margin = (flBtnSide - flDrawSide) / 2;
    
    CGContextMoveToPoint(context, margin, margin + flDrawSide/2);
    CGContextAddLineToPoint(context, margin + flDrawSide, margin + flDrawSide/2);
    
    CGContextMoveToPoint(context, margin + flDrawSide/2, margin);
    CGContextAddLineToPoint(context, margin, margin + flDrawSide/2);
    CGContextAddLineToPoint(context, margin + flDrawSide/2, margin + flDrawSide);
    
    CGContextStrokePath(context);
}

@end
