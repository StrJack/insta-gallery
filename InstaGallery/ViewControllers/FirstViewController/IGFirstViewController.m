//
//  IGFirstViewController.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGFirstViewController.h"
#import "IGSecondViewController.h"

#import "IGTopPanel.h"
#import "IGMiddlePanel.h"
#import "IGTablePanel.h"
#import "IGWaiter.h"

#import "IGCloseButton.h"
#import "IGFlashButton.h"
#import "IGPreviousButton.h"
#import "IGShotButton.h"
#import "IGPickerButton.h"
#import "IGFrontalButton.h"
#import "IGRulerButton.h"
#import "IGGrid.h"

#define CAMERA_TRANSFORM 1.24

static inline double radians (double degrees) {return degrees * M_PI/180;}
static UIImagePickerController *static_image_picker;
static void(^static_completion_block)(UIImage *image, UIImagePickerController *);

@interface IGFirstViewController ()

@end

@implementation IGFirstViewController

+ (void)acomplishWithImage:(UIImage *)image {
    static_completion_block(image, static_image_picker);
}

- (id)initWithCompletion:(void(^)(UIImage *, UIImagePickerController *))completionBlock {
    if (self = [super init]) {
        static_image_picker = self;
        static_completion_block = completionBlock;
        
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.delegate = self;
        self.showsCameraControls = NO;
        self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.secondViewController = nil;
    
    [self.topPanel removeFromSuperview];
    self.topPanel = [[IGTopPanel alloc]
                     initWithLeftButton:[[[IGCloseButton alloc] init] addTarget:self action:@selector(closePage)]
                     rightButton:nil
                     titleString:nil
                     forView:self.view];
    
    self.grid = [[IGGrid alloc] init];
    LocateUnder(self.grid, self.topPanel, 0);
    
    self.waiter = [[IGWaiter alloc] initForView:self.grid active:NO];
    
    self.middlePanel = [[IGMiddlePanel alloc] initWithLeftButton:[[[IGRulerButton alloc] init] addTarget:self action:@selector(showGrid)]
                                                     rightButton:[[[IGFlashButton alloc] init] addTarget:self action:@selector(flash)]
                                                    middleButton:[[[IGFrontalButton alloc] init] addTarget:self action:@selector(expand)]];
    [self.middlePanel.leftButton setSelected:YES];
    LocateUnder(self.middlePanel, self.grid, 0);
    
    self.tablePanel = [[IGTablePanel alloc] initRelativelyLast:self.middlePanel andBase:self.view];
    self.shotButton = [[[IGShotButton alloc] initForView:self.tablePanel] addTarget:self action:@selector(shot)];
    
    self.pickerButton = [[[IGPickerButton alloc] init] addTarget:self action:@selector(openLibrary)];
    LocateLeft(self.pickerButton, self.shotButton, 20.0, 0.0);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Shows
- (void)updateToShowCropAndScale {
    IGTopPanel *newTopPanel = [[IGTopPanel alloc] initWithLeftButton:[[IGPreviousButton alloc] init] rightButton:nil titleString:@"SCALE & CROP" forView:self.view];
    [self.topPanel shouldChangeWithNew:newTopPanel derection:(IGDirectionTypeLeft)];
    self.topPanel = newTopPanel;
    
    IGTablePanel *newTablePanel = [[IGTablePanel alloc] initRelativelyLast:self.grid andBase:self.view];
    [self.tablePanel shouldChangeWithNew:newTablePanel derection:(IGDirectionTypeRight)];
    
    [self shot];
//    [self performSelector:@selector(showNextViewController) withObject:nil afterDelay:0.5];
}

- (void)showNextViewController {
    
    [self presentViewController:self.secondViewController animated:NO completion:nil];
}

#pragma mark - Actions
- (void)showGrid {
    self.middlePanel.leftButton.selected = !self.middlePanel.leftButton.selected;
    if (self.middlePanel.leftButton.selected)
        [self.grid showGrid];
    else
        [self.grid hideGrid];
}
- (void)flash {
    self.middlePanel.rightButton.selected = !self.middlePanel.rightButton.selected;
    self.cameraFlashMode = !self.cameraFlashMode;
}

- (void)expand {
    self.cameraDevice = !self.cameraDevice;
}

- (void)shot {
    [self takePicture];
}

- (void)closePage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openLibrary {
    UIImagePickerController *imPickerController = [[UIImagePickerController alloc] init];
    imPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imPickerController.delegate = self;
    
    [self presentViewController:imPickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (picker != self) {
        [picker dismissViewControllerAnimated:YES completion:^{
            UIImage *newImage = rotate(image, UIImageOrientationDown);
            CGRect gridRect = CGRectMake(0.0f, (newImage.size.height - newImage.size.width)/2, newImage.size.width, newImage.size.width);
            _resultImage = [IGFirstViewController cropImage:image byRect:gridRect];
            
            self.secondViewController = [[IGSecondViewController alloc] initWithPreviousViewController:self];
            [self showNextViewController];
        }];
        return;
    }
    
    image = rotate(image, UIImageOrientationDown);
    
    CGRect gridRect = CGRectMake(0.0f, (image.size.height - image.size.width)/2, image.size.width, image.size.width);
    _resultImage = [IGFirstViewController cropImage:image byRect:gridRect];
    
    if (self.secondViewController) {
        [self showNextViewController];
        [self.secondViewController updateImage:_resultImage];
    } else {
        [self.grid shot];
        self.secondViewController = [[IGSecondViewController alloc] initWithPreviousViewController:self];
        [self updateToShowCropAndScale];
    }
}

#pragma mark - Additional Functions
+ (UIImage *)cropImage:(UIImage *)image byRect:(CGRect)gridRect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], gridRect);
    image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    // UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
UIImage* rotate(UIImage* src, UIImageOrientation orientation)
{
    UIGraphicsBeginImageContext(src.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, radians(90));
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, radians(-90));
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, radians(90));
    }
    
    [src drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
