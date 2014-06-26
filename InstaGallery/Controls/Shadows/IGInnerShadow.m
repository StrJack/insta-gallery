//
//  IGInnerShadow.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/19/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGInnerShadow.h"

@implementation IGInnerShadow

#pragma mark - Shadows
+ (void)drawInnerShadowOnView:(UIView *)view shadowWidth:(CGFloat)shadowWidth {
    UIImageView *innerShadowView = [[UIImageView alloc] initWithFrame:CGRectMake(-shadowWidth, -shadowWidth, view.frame.size.width+shadowWidth*2, view.frame.size.height+shadowWidth*2)];
    
    innerShadowView.contentMode = UIViewContentModeScaleToFill;
    innerShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [view addSubview:innerShadowView];
    
    [innerShadowView.layer setMasksToBounds:YES];
    
    [innerShadowView.layer setBorderColor:[UIColor redColor].CGColor];
    [innerShadowView.layer setShadowColor:[UIColor blackColor].CGColor];
    [innerShadowView.layer setBorderWidth:shadowWidth];
    
    [innerShadowView.layer setShadowOffset:CGSizeMake(0, shadowWidth/2)];
    [innerShadowView.layer setShadowOpacity:1.0];
    
    // this is the inner shadow thickness
    [innerShadowView.layer setShadowRadius:10.5];
}

@end
