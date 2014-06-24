//
//  IGSecondViewController.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IGTopPanel.h"
#import "IGTablePanel.h"
#import "IGGrid.h"
#import "IGNextButton.h"
#import "IGCloseButton.h"
#import "IGPreviousButton.h"

@interface IGSecondViewController : UIViewController {
    UIImage *_image;
}

@property (nonatomic, strong) IGTopPanel *topPanel;
@property (nonatomic, strong) IGTablePanel *tablePanel;
@property (nonatomic, strong) IGGrid *grid;
@property (nonatomic, strong) UIImageView *imageView;

- (id)initWithPreviousViewController:(IGFirstViewController *)firstViewController;
- (id)initWithImage:(UIImage*)image;

@end
