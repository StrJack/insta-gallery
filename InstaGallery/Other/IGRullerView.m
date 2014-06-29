//
//  IGRullerView.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/28/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGRullerView.h"


@interface IGRullerContentView : UIView

- (id)initWithSupreview:(UIView *)sView;

@end

@implementation IGRullerContentView

- (id)initWithSupreview:(UIView *)sView {
    if (self = [super initWithFrame:(CGRectMake(0, sView.frame.size.height * 0.1, sView.frame.size.width * 5, sView.frame.size.height * 0.9))]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGFloat startPoint_X = rect.size.width/2;
    CGFloat stepWidth = 10.0;
    
    int i = 0;
    while (i*stepWidth < startPoint_X - rect.size.width/10) {
        CGFloat startPoint_Y = i % 5 ? rect.size.height/2 : 0;
        
        CGContextMoveToPoint(context, startPoint_X - i*stepWidth, startPoint_Y);
        CGContextAddLineToPoint(context, startPoint_X - i*stepWidth, rect.size.height);
        
        CGContextMoveToPoint(context, startPoint_X + i*stepWidth, startPoint_Y);
        CGContextAddLineToPoint(context, startPoint_X + i*stepWidth, rect.size.height);
        
        i++;
    }
    
    CGContextStrokePath(context);
}

@end

/* ------------ */

@implementation IGRullerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.bounces = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        
        self.contentView = [[IGRullerContentView alloc] initWithSupreview:self];
        
        [self setContentSize:self.contentView.frame.size];
        [self addSubview:self.contentView];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(context, 4.0);
    
    CGContextMoveToPoint(context, rect.size.width/2, 0.0);
    CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height);
    
    CGContextStrokePath(context);
    
    [self scrollRectToVisible:(CGRectMake(self.contentView.frame.size.width/2 + self.contentView.frame.size.width/10, 0, 1, self.frame.size.height)) animated:NO];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self animateHide];
}

- (void)animateShow:(UIView *)base {
    __block CGRect rullerRect = self.frame;
    rullerRect.origin.x = rullerRect.size.width;
    self.frame = rullerRect;
    [base addSubview:self];
    
    [UIView animateWithDuration:0.1 animations:^{
        rullerRect.origin.x = 0;
        self.frame = rullerRect;
    }];
}

- (void)animateHide {
    CGRect rullerRect = self.frame;
    rullerRect.origin.x = -rullerRect.size.width;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = rullerRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animateHide];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.scrollDelegate rotationWithKoef:scrollView.contentOffset.x / (scrollView.contentSize.width)/0.4];
//    NSLog(@"%f", scrollView.contentOffset.x / (scrollView.contentSize.width)/0.4);
}

@end


