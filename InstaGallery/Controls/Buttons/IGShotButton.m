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
    CGFloat btnLength = baseView.bounds.size.height < flBtnSide ? baseView.bounds.size.height*0.85 : flBtnSide;
    
    if (self = [super initWithFrame:(CGRectMake(0.0f, 0.0f, btnLength, btnLength))]) {
        self.center = CGPointMake(baseView.bounds.size.width/2, baseView.bounds.size.height/2);
        [baseView addSubview:self];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat lineWidth = IS_4INCH_SCREEN ? flLineWidth : 2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetLineWidth(context, lineWidth);
    
    CGRect ellipseRect = rect;
    ellipseRect.size.width = ellipseRect.size.height -= lineWidth*2;
    ellipseRect.origin.x = ellipseRect.origin.y += lineWidth;
    CGContextAddEllipseInRect(context, ellipseRect);
    CGContextStrokePath(context);
    
    ellipseRect = CGRectInset(ellipseRect, 7, 7);
    CGContextSetFillColor(context, CGColorGetComponents(COLOR_PANTONE_1225.CGColor));
    CGContextFillEllipseInRect(context, ellipseRect);
    
}

@end
