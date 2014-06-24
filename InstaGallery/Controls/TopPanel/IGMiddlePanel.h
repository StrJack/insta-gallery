//
//  IGMiddlePanel.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGTopPanel.h"

@interface IGMiddlePanel : IGTopPanel

@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *rightButton;

- (id)initWithLeftButton:(UIButton*)leftButton rightButton:(UIButton*)rightButton middleButton:(UIButton*)middleButton;

@end
