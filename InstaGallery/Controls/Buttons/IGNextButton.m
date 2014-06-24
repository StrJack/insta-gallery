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
    if (self = [super initWithFrame:CGRectMake(0.0, 0.0, 46.0, 54.0)]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [self setTitle:@"NEXT" forState:(UIControlStateNormal)];
    }
    return self;
}

@end
