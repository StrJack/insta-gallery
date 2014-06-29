//
//  IGRullerView.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/28/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IGRullerViewDelegate

- (void)rotationWithKoef:(CGFloat)koef;

@end

@interface IGRullerView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id scrollDelegate;
@property (nonatomic, strong) UIView *contentView;

- (void)animateShow:(UIView *)base;
- (void)animateHide;

@end
