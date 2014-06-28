//
//  IGBrigtnessButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/28/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGBrigtnessButton.h"

@implementation IGBrigtnessButton

- (id)init {
    if (self = [super init]) {
        [self setImage:[self makeBrighter] forState:(UIControlStateSelected)];
    }
    return self;
}

- (NSString *)buttonImageName {
    return @"brightness.png";
}

@end
