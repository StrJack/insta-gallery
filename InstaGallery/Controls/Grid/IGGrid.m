//
//  IGGrid.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGGrid.h"

#define flLineWidth        2.0f

@implementation IGGrid {
    BOOL _show;
    UIView *_top, *_bottom;
}

- (id)init {
    if (self = [super initWithFrame:(CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_WIDTH))]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        _show = YES;
        
        _top = [[UIView alloc] initWithFrame:self.bounds];
        _bottom = [[UIView alloc] initWithFrame:self.bounds];
        _top.backgroundColor = _bottom.backgroundColor = [UIColor blackColor];
        
        LocateAbove(_top, self, 0);
        [self addSubview:_top];
        
        LocateUnder(_bottom, self, 0);
        [self addSubview:_bottom];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)showGrid {
    _show = YES;
    [self setNeedsDisplay];
}

- (void)hideGrid {
    _show = NO;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!_show) return;
        
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor);
    
    CGContextSetLineWidth(context, flLineWidth);
    
    for (int i = 1; i < 3; ++i) {
        CGContextMoveToPoint(context, SCREEN_WIDTH / 3 * i, 0);
        CGContextAddLineToPoint(context, SCREEN_WIDTH / 3 * i, SCREEN_WIDTH);

        CGContextMoveToPoint(context, 0, SCREEN_WIDTH / 3 * i);
        CGContextAddLineToPoint(context, SCREEN_WIDTH, SCREEN_WIDTH / 3 * i);
    }
    
    CGContextStrokePath(context);
}

- (void)shot {
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _top.center = CGPointMake(self.center.x, self.center.y - self.frame.origin.y);
        _bottom.center = CGPointMake(self.center.x, self.center.y - self.frame.origin.y);
    }];
    
}

- (void)open {
    [UIView animateWithDuration:0.9 animations:^{
        _top.center = CGPointMake(self.center.x, -self.bounds.size.height/2);
        _bottom.center = CGPointMake(self.center.x, self.bounds.size.height*1.5);
    }];
}

@end
