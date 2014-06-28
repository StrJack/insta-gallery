//
//  IGMiddlePanel.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGMiddlePanel.h"

@implementation IGMiddlePanel

- (id)initWithLeftButton:(UIButton*)leftButton rightButton:(UIButton*)rightButton middleButton:(UIButton*)middleButton {
    if(self = [super initWithLeftButton:leftButton rightButton:rightButton titleString:nil forView:nil]){
        self.leftButton = leftButton;
        self.leftButton.center = CGPointMake((self.bounds.size.width/3)*0.6, self.bounds.size.height/2);
        
        self.middleButton = middleButton;
        self.middleButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        self.rightButton = rightButton;
        self.rightButton.center = CGPointMake((self.bounds.size.width/3)*2.4, self.bounds.size.height/2);
        
        [self addSubview:self.leftButton];
        [self addSubview:self.middleButton];
        [self addSubview:self.rightButton];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.leftButton.center = CGPointMake(self.leftButton.center.x, frame.size.height/2);
    self.middleButton.center = CGPointMake(self.middleButton.center.x, frame.size.height/2);
    self.rightButton.center = CGPointMake(self.rightButton.center.x, frame.size.height/2);
}

@end
