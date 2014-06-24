//
//  IGBaseView.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGBaseView.h"

@implementation IGBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)shouldChangeWithNew:(IGBaseView *)view derection:(IGDirectionType)direction {
    [self doesNotRecognizeSelector:_cmd];
}

@end
