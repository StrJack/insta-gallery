//
//  IGBaseView.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IGBaseView;

typedef enum : NSUInteger {
    IGDirectionTypeLeft,
    IGDirectionTypeRight,
    IGDirectionTypeUp,
    IGDirectionTypeDown
} IGDirectionType;

@protocol IGBaseViewProtocol

- (void)shouldChangeWithNew:(IGBaseView *)view derection:(IGDirectionType)direction;

@end

@interface IGBaseView : UIView <IGBaseViewProtocol>

@end
