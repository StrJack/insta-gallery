//
//  IGInnerShadow.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/19/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGInnerShadow.h"

@implementation IGInnerShadow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        [[self layer] setMasksToBounds:YES];
//        [[self layer] setCornerRadius:10.0f];
//        [[self layer] setBorderColor:[[UIColor blackColor] CGColor]];
//        [[self layer] setBorderWidth:12.0f];
//        [[self layer] setShadowColor:[[UIColor blackColor] CGColor]];
//        [[self layer] setShadowOffset:CGSizeMake(0, 10)];
//        [[self layer] setShadowOpacity:1];
//        [[self layer] setShadowRadius:12.0];

        CALayer *innerShadowOwnerLayer = [[CALayer alloc]init];
        innerShadowOwnerLayer.frame = CGRectMake(0, 0, self.frame.size.width, 10);
        innerShadowOwnerLayer.backgroundColor = [UIColor whiteColor].CGColor;
        
        innerShadowOwnerLayer.shadowColor = [UIColor blackColor].CGColor;
        innerShadowOwnerLayer.shadowOffset = CGSizeMake(0, 0);
        innerShadowOwnerLayer.shadowRadius = 15.0;
        innerShadowOwnerLayer.shadowOpacity = 1;
        
        [self.layer addSublayer:innerShadowOwnerLayer];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}


@end
