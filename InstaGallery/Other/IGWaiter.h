//
//  IGWaiter.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/22/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGBaseView.h"

@interface IGWaiter : IGBaseView

- (id)initForView:(UIView *)baseView active:(BOOL)isActive;
- (void)start;
- (void)stop;

@end
