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

@implementation IGApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self presentViewController:[[IGFirstViewController alloc] initWithCompletion:^(UIImage *image, UIImagePickerController *vc) {
    }] animated:YES completion:nil];
}

@end
