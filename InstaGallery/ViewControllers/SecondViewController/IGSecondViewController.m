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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.topPanel = [[IGTopPanel alloc]
                     initWithLeftButton:[[[IGPreviousButton alloc] init] addTarget:self action:@selector(close)]
                     rightButton:[[[IGNextButton alloc] init]
                                  addTarget:self
                                  action:@selector(next)]
                     titleString:@"SCALE & CROP" forView:self.view];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_WIDTH)];
    self.imageView.image = _image;
    self.imageView.userInteractionEnabled = YES;
    LocateUnder(self.imageView, self.topPanel, 0);
    [self.view insertSubview:self.imageView belowSubview:self.topPanel];
    
    self.grid = _firstViewController.grid;//[[IGGrid alloc] init];
    LocateUnder(self.grid, self.topPanel, 0);
    
    self.tablePanel = [[IGTablePanel alloc] initRelativelyLast:self.imageView andBase:self.view];
    
    [self.imageView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)]];
    [self.imageView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.grid open];
}

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

#pragma mark - Actions
- (void)close {
    [self updateToTakePhoto];
}

- (void)next {
    CGRect cropRect = CGRectMake(ABS(self.imageView.frame.origin.x), ABS(self.imageView.frame.origin.y - self.topPanel.frame.size.height), 520, 520);
    
    CGFloat imSideLength = _image.size.width;
    CGFloat imViewSideLength = self.imageView.frame.size.width;
    
    cropRect = CGRectMake(cropRect.origin.x / imViewSideLength * imSideLength, cropRect.origin.y / imViewSideLength * imSideLength, cropRect.size.width / imViewSideLength * imSideLength, cropRect.size.height / imViewSideLength * imSideLength);
    
    UIImage *image = [IGFirstViewController cropImage:self.imageView.image byRect:cropRect];
    _resultImage = [IGFirstViewController imageWithImage:image scaledToSize:CGSizeMake(120, 120)];
    
    [self updateToEdit];
}

// To zoom in/out
- (void)pinched:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = sender.scale + _lastScale;
    
    if (scale >1.0f && scale < 5.5f) {
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        self.imageView.transform = transform;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded){
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
    
    [self correctImage];
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
