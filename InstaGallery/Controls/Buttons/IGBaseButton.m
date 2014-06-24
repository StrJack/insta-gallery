//
//  IGBaseButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGBaseButton.h"

@implementation IGBaseButton

- (instancetype)addTarget:(id)target action:(SEL)action {
    [self addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return self;
}
@end
