//
//  IGShotButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGShotButton.h"

#define flBtnSide           96.0f
#define flLineWidth         5.0f
#define flBtmPadding        18.0f

@implementation IGShotButton

- (id)initForView:(UIView*)baseView {
    
    if (self = [super initWithFrame:(CGRectMake(0.0f, 0.0f, flBtnSide, flBtnSide))]) {
        self.center = CGPointMake(baseView.bounds.size.width/2, baseView.bounds.size.height/2);
        [baseView addSubview:self];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetLineWidth(context, flLineWidth);
    
    CGRect ellipseRect = rect;
    ellipseRect.size.width = ellipseRect.size.height -= flLineWidth*2;
    ellipseRect.origin.x = ellipseRect.origin.y += flLineWidth;
    CGContextAddEllipseInRect(context, ellipseRect);
    CGContextStrokePath(context);
    
    ellipseRect = CGRectInset(ellipseRect, 7, 7);
    CGContextSetFillColor(context, CGColorGetComponents(RGB(255, 200, 69, 1).CGColor));
    CGContextFillEllipseInRect(context, ellipseRect);
    
}

@end
