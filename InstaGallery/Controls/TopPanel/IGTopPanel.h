//
//  IGTopPanel.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGBaseView.h"

@interface IGTopPanel : IGBaseView

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *title;

- (id)initWithLeftButton:(UIButton*)leftButton rightButton:(UIButton*)rightButton titleString:(NSString*)title forView:(UIView*)baseView;

@end
