//
//  IGContrastButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/27/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGContrastButton.h"

@implementation IGContrastButton

- (id)init {
    if (self = [super init]) {
        [self setImage:[self makeBrighter] forState:(UIControlStateSelected)];
    }
    return self;
}

- (NSString *)buttonImageName {
    return @"contrast.png";
}

@end
