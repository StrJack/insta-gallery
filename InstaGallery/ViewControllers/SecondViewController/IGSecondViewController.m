//
//  IGSecondViewController.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/17/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGFirstViewController.h"
#import "IGSecondViewController.h"
#import "IGThirdViewController.h"

#import "IGInnerShadow.h"

@interface IGSecondViewController () {
    __weak IGFirstViewController *_firstViewController;
    UIImage *_resultImage;
    
    CGFloat _firstX;
    CGFloat _firstY;
    CGFloat _lastScale;
}

@end

@implementation IGSecondViewController

- (id)initWithPreviousViewController:(IGFirstViewController *)firstViewController {
    if (self = [self initWithImage:firstViewController.resultImage]) {
        _firstViewController = firstViewController;
    }
    return self;
}

- (id)initWithImage:(UIImage*)image {
    if (self = [super init]) {
        _image = image;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.topPanel removeFromSuperview];
    self.topPanel = [[IGTopPanel alloc]
                     initWithLeftButton:[[[IGPreviousButton alloc] init] addTarget:self action:@selector(close)]
                     rightButton:[[[IGNextButton alloc] init]
                                  addTarget:self
                                  action:@selector(next)]
                     titleString:@"SCALE & CROP" forView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topPanel = [[IGTopPanel alloc]
                     initWithLeftButton:[[[IGPreviousButton alloc] init] addTarget:self action:@selector(close)]
                     rightButton:[[[IGNextButton alloc] init]
                                  addTarget:self
                                  action:@selector(next)]
                     titleString:@"SCALE & CROP" forView:self.view];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_WIDTH)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = _image;
    self.imageView.userInteractionEnabled = YES;
    LocateUnder(self.imageView, self.topPanel, 0);
    [self.view insertSubview:self.imageView belowSubview:self.topPanel];
    
    self.grid = _firstViewController.grid;
    LocateUnder(self.grid, self.topPanel, 0);
    
    self.tablePanel = [[IGTablePanel alloc] initRelativelyLast:self.imageView andBase:self.view];
    
    if ([self isMemberOfClass:[IGSecondViewController class]])
        [self.tablePanel addSubview:[[IGPhotoGaleryView alloc] initWithFrame:self.tablePanel.bounds andDelegate:self]];
    
    
    UIView *shadow = [[UIView alloc] initWithFrame:self.tablePanel.bounds];
    shadow.backgroundColor = [UIColor clearColor];
    shadow.userInteractionEnabled = NO;
    [IGInnerShadow drawInnerShadowOnView:shadow shadowWidth:25.];
    
    [self.tablePanel addSubview:shadow];
    
    [self.imageView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)]];
    [self.imageView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.grid open];
}

#pragma mark - IGPhotoGaleryDelegate
- (void)gotImageFromLibrary:(UIImage *)image {
    [self.imageView.layer setMasksToBounds:YES];
    self.imageView.image = image;
}

#pragma mark - Updating
- (void)updateToTakePhoto {
    [self.topPanel shouldChangeWithNew:[[IGTopPanel alloc] initWithLeftButton:[[IGCloseButton alloc] init] rightButton:nil titleString:@"TAKE A PHOTO" forView:self.view] derection:(IGDirectionTypeRight)];
    [self.tablePanel shouldChangeWithNew:nil derection:(IGDirectionTypeDown)];
    
    [self performSelector:@selector(showPreviousViewController) withObject:nil afterDelay:0.5];
}

- (void)updateToEdit {
    [self.grid hideGrid];
    [self.topPanel shouldChangeWithNew:[[IGTopPanel alloc] initWithLeftButton:[[IGPreviousButton alloc] init] rightButton:[[IGNextButton alloc] init] titleString:@"EDIT" forView:self.view] derection:(IGDirectionTypeLeft)];
    
    [self performSelector:@selector(showNextViewCnotroller) withObject:nil afterDelay:0.5];
}

- (void)showPreviousViewController {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)showNextViewCnotroller {
    [self presentViewController:[[IGThirdViewController alloc] initWithImage:_resultImage] animated:NO completion:nil];
}

- (void)updateImage:(UIImage *)image {
//    NSLog(@"%s", __PRETTY_FUNCTION__);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_WIDTH)];
        imView.contentMode = UIViewContentModeScaleAspectFill;
        imView.image = self.imageView.image;
        [self.imageView addSubview:imView];
        
        [self.imageView setImage:image];
        
        [UIView animateWithDuration:0.3 animations:^{
            imView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [imView removeFromSuperview];
        }];
    });
}

#pragma mark - Actions
- (void)close {
    [self updateToTakePhoto];
}

- (void)next {
    CGRect cropRect = CGRectMake(ABS(self.imageView.frame.origin.x), ABS(self.imageView.frame.origin.y - self.topPanel.frame.size.height), 320, 320);
    
    CGFloat imSideLength = _image.size.width;
    CGFloat imViewSideLength = self.imageView.frame.size.width;
    
    cropRect = CGRectMake(cropRect.origin.x / imViewSideLength * imSideLength, cropRect.origin.y / imViewSideLength * imSideLength, cropRect.size.width / imViewSideLength * imSideLength, cropRect.size.height / imViewSideLength * imSideLength);
    
    UIImage *image = [IGFirstViewController cropImage:self.imageView.image byRect:cropRect];
    _resultImage = [IGFirstViewController imageWithImage:image scaledToSize:CGSizeMake(320, 320)];
    
    [self updateToEdit];
}

// To zoom in/out
- (void)pinched:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = sender.scale + _lastScale;
    
    if (scale > 0.5f && scale < 5.5f) {
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        self.imageView.transform = transform;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded){
        
        if (scale < 1.0f) {
            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            self.imageView.transform = transform;
        }
        _lastScale = [self xscale:self.imageView] - 1;

        [self correctImage];
    }
}

// To rotate
- (void)panned:(UIGestureRecognizer *)gesture {
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)gesture translationInView:self.imageView];

    if([(UIPanGestureRecognizer*)gesture state] == UIGestureRecognizerStateBegan) {
        _firstX = [self.imageView center].x;
        _firstY = [self.imageView center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
    [self.imageView setCenter:translatedPoint];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self correctImage];
    }
}

- (void)correctImage {
    CGRect imViewRect = self.imageView.frame;
    if (imViewRect.origin.x > 0)
        imViewRect.origin.x = 0;
    else if (imViewRect.size.width + imViewRect.origin.x <= SCREEN_WIDTH)
        imViewRect.origin.x = SCREEN_WIDTH - imViewRect.size.width;
    
    if (imViewRect.origin.y > self.grid.frame.origin.y)
        imViewRect.origin.y = self.grid.frame.origin.y;
    else if (imViewRect.size.height - self.grid.frame.origin.y + imViewRect.origin.y < SCREEN_WIDTH)
        imViewRect.origin.y = SCREEN_WIDTH - imViewRect.size.height + self.grid.frame.origin.y;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.frame = imViewRect;
    }];
}

#pragma mark - Additional Functions
- (CGFloat)xscale:(UIView*)view {
    CGAffineTransform t = view.transform;
    return sqrt(t.a * t.a + t.c * t.c);
}

- (CGFloat)yscale:(UIView*)view {
    CGAffineTransform t = view.transform;
    return sqrt(t.b * t.b + t.d * t.d);
}

@end
