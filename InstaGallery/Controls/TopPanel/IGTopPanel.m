//
//  IGTopPanel.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGTopPanel.h"

#define flPanelHeight           54.f
#define flBtnPadding            15.f

@implementation IGTopPanel

- (id)initWithLeftButton:(UIButton*)leftButton rightButton:(UIButton*)rightButton titleString:(NSString*)title forView:(UIView*)baseView {
    
    CGRect baseViewRect = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:(CGRectMake(0.0f, 0.0f, baseViewRect.size.width, flPanelHeight))]) {
        if ([self isMemberOfClass:[IGTopPanel class]]){
            NSAssert1([UIScreen mainScreen].bounds.size.width == baseView.bounds.size.width, @"BaseView.width != UIScreen.width", 0);
            [baseView addSubview:self];
        }
        
        self.backgroundColor = bgBlackTransparentColor;
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:self.bounds];
        lblTitle.font = [UIFont boldSystemFontOfSize:21.0f];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = title;
        
        self.title = lblTitle;
        
        if (leftButton) {
            self.leftButton = leftButton;
            leftButton.center = CGPointMake(leftButton.bounds.size.width/2, self.bounds.size.height/2);
            
            [self addSubview:leftButton];
        }
        
        if (rightButton) {
            self.rightButton = rightButton;
            rightButton.center = CGPointMake(baseViewRect.size.width - rightButton.bounds.size.width/2 - flBtnPadding, self.bounds.size.height/2);
            
            [self addSubview:rightButton];
        }
        
        [self addSubview:lblTitle];
    }
    
    return self;
}

- (void)shouldChangeWithNew:(IGBaseView *)view derection:(IGDirectionType)direction {
    IGTopPanel *newTopPanel = (IGTopPanel *)view;
    newTopPanel.leftButton.alpha = newTopPanel.rightButton.alpha = newTopPanel.title.alpha = 0.0;
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.center = CGPointMake(self.frame.size.width * ((direction == IGDirectionTypeLeft) ? -1 : 1), self.center.y);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            newTopPanel.leftButton.alpha = newTopPanel.rightButton.alpha = newTopPanel.title.alpha = 1.0;
        }];
    }];
}

@end
