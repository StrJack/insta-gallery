//
//  IGApplicationViewController.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGApplicationViewController.h"
#import "IGFirstViewController.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface IGApplicationViewController ()
@end

@implementation IGApplicationViewController {
    UIImage *_image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self presentViewController:[[IGFirstViewController alloc] initWithCompletion:^(UIImage *image, UIImagePickerController *vc) {
            _image = image;
            [self dismissViewControllerAnimated:YES completion:^{
                UIImageView *imView = [[UIImageView alloc] initWithImage:_image];
                [self.view addSubview:imView];
            }];
        }] animated:YES completion:nil];
    });
    
}

@end
