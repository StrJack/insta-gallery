//
//  IGNextButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGNextButton.h"

@implementation IGNextButton

- (id)init {
    if (self = [super initWithFrame:CGRectMake(0.0, 0.0, 56.0, 54.0)]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [self setTitleColor:COLOR_PANTONE_1225 forState:(UIControlStateNormal)];
        [self setTitle:@"NEXT" forState:(UIControlStateNormal)];
    }
    return self;
}

@end
