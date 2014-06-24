//
//  IGWaiter.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/22/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGWaiter.h"

@implementation IGWaiter

- (id)initForView:(UIView *)baseView active:(BOOL)isActive {
    if (self = [super initWithFrame:baseView.bounds]) {
        self.backgroundColor = bgBlackTransparentColor;
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        indicator.center = self.center;
        [indicator startAnimating];
        
        [self addSubview:indicator];
        [baseView addSubview:self];
        
        isActive ? [self start] : [self stop];
    }
    
    return self;
}

- (void)start {
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = NO;
    }];
}

- (void)stop {
    self.hidden = YES;
}

@end
