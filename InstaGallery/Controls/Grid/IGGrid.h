//
//  IGGrid.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGGrid : UIView

- (void)showGrid;
- (void)hideGrid;

- (void)shotWithCompletion:(void(^)())completion;
- (void)open;

@end
