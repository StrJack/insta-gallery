//
//  IGFirstViewController.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IGTopPanel, IGTopPanel, IGTablePanel, IGWaiter, IGShotButton, IGPickerButton, IGGrid, IGSecondViewController;

@interface IGFirstViewController : UIImagePickerController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) UIImage *resultImage;

@property (nonatomic, strong) IGSecondViewController *secondViewController;
@property (nonatomic, strong) IGTopPanel *topPanel;
@property (nonatomic, strong) IGTopPanel *middlePanel;
@property (nonatomic, strong) IGTablePanel *tablePanel;
@property (nonatomic, strong) IGWaiter *waiter;
@property (nonatomic, strong) IGShotButton *shotButton;
@property (nonatomic, strong) IGPickerButton *pickerButton;
@property (nonatomic, strong) IGGrid *grid;


+ (void)acomplishWithImage:(UIImage *)image;
- (id)initWithCompletion:(void(^)(UIImage *, UIImagePickerController *))completionBlock;

+ (UIImage *)cropImage:(UIImage *)image byRect:(CGRect)gridRect;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
