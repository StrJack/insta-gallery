//
//  IGRulerButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/23/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGRulerButton.h"

@implementation IGRulerButton

- (id)init {
    if (self = [super init]) {
        [self setImage:[self makeBrighter] forState:(UIControlStateSelected)];
    }
    return self;
}

- (NSString *)buttonImageName {
    return @"ruler.png";
}

@end
