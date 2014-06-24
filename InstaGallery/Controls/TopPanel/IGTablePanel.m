//
//  IGTablePanel.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGTablePanel.h"

@implementation IGTablePanel

- (id)initRelativelyLast:(UIView *)lastView andBase:(UIView *)baseView {
    CGRect baseViewRect = baseView.frame;
    CGRect lastViewRect = lastView.frame;
    CGFloat tableY = lastViewRect.origin.y + lastViewRect.size.height;
    if (self = [super initWithFrame:(CGRectMake(0.0, tableY, SCREEN_WIDTH, baseViewRect.size.height - tableY))]) {
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = YES;
        [baseView addSubview:self];
    }
    return self;
}

- (void)shouldChangeWithNew:(IGBaseView *)view derection:(IGDirectionType)direction {
    IGTablePanel *newTablePanel = (IGTablePanel *)view;
    [self.superview insertSubview:newTablePanel belowSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.center = CGPointMake(self.frame.size.width/2, self.center.y + self.bounds.size.height * ((direction == IGDirectionTypeUp) ? -1 : 1));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
