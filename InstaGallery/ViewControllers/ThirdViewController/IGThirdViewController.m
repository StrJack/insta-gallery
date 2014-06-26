//
//  IGThirdViewController.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/18/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGFirstViewController.h"
#import "IGThirdViewController.h"

#import "IGFilterScrollerViewCell.h"

#import "IGHorizontalScroller.h"
#import "IGInnerShadow.h"

#import "UIImage+FiltrrCompositions.h"

#define NUM_FILTERS             11
#define FILTER_LEFT_PADDING     3

@interface IGThirdViewController ()

@end

@implementation IGThirdViewController {
    UIImage *_thumbImage;
    NSArray *_filteredImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelectorInBackground:@selector(renderImages) withObject:nil];
}

- (void)renderImages{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < NUM_FILTERS; ) {
        [arr addObject:[_image performSelector:NSSelectorFromString([@"e" stringByAppendingFormat:@"%d", ++i]) withObject:nil]];
        _filteredImages = arr;
    }
    NSLog(@"finish!");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view insertSubview:self.tablePanel belowSubview:self.imageView];
    self.tablePanel.backgroundColor = [UIColor darkGrayColor];
    
    _thumbImage = [IGFirstViewController imageWithImage:_image scaledToSize:[IGFilterScrollerViewCell thumbnailImageSize]];
    
    CGFloat contentViewWidth = NUM_FILTERS * ([IGFilterScrollerViewCell cellWidth] + FILTER_LEFT_PADDING);
    UIView *contentView = [[UIView alloc] initWithFrame:(CGRectMake(0.0, 0.0, contentViewWidth, [IGFilterScrollerViewCell cellHeight]))];
    contentView.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < NUM_FILTERS;) {
        UIImage *thumbImage = [_thumbImage performSelector:NSSelectorFromString([NSString stringWithFormat:@"e%d", i+1])  withObject:nil];
        NSString *filterName = [@"Filter " stringByAppendingFormat:@"%d", i+1];
        
        UIView *cellView = [[IGFilterScrollerViewCell alloc] initWithThumbnail:thumbImage text:filterName];
        cellView.center = CGPointMake(i * (cellView.bounds.size.width + FILTER_LEFT_PADDING) + cellView.bounds.size.width/2, contentView.bounds.size.height/2);
        cellView.backgroundColor = [UIColor blackColor];
        [contentView addSubview:cellView];
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = cellView.bounds;
        button.tag = ++i;
        [button addTarget:self action:@selector(cellTap:) forControlEvents:(UIControlEventTouchUpInside)];
        [cellView addSubview:button];
    }
    
    [self.grid removeFromSuperview];
    self.imageView.gestureRecognizers = nil;
    self.topPanel.title.text = @"EDIT";
    
    
    IGHorizontalScroller *horizontalScroller = [[IGHorizontalScroller alloc] initWithCellType:[IGFilterScrollerViewCell class]];
    horizontalScroller.center = CGPointMake(self.tablePanel.frame.size.width/2, self.tablePanel.bounds.size.height - [IGFilterScrollerViewCell cellHeight]/2);
    
    [horizontalScroller addSubview:contentView];
    [horizontalScroller setContentSize:contentView.bounds.size];
    
    [self.tablePanel addSubview:horizontalScroller];
    
    
    UIView *shadow = [[UIView alloc] initWithFrame:self.tablePanel.frame];
    shadow.backgroundColor = [UIColor clearColor];
    shadow.userInteractionEnabled = NO;
    [IGInnerShadow drawInnerShadowOnView:shadow shadowWidth:16.];
    [self.tablePanel addSubview:shadow];
}

- (void)updateToTakePhoto {
    [self.topPanel shouldChangeWithNew:[[IGTopPanel alloc] initWithLeftButton:[[IGPreviousButton alloc] init] rightButton:[[IGNextButton alloc] init] titleString:@"SCALE & CROP" forView:self.view] derection:(IGDirectionTypeRight)];
    [self.tablePanel shouldChangeWithNew:nil derection:(IGDirectionTypeUp)];
    
    [self performSelector:@selector(showPreviousViewController) withObject:nil afterDelay:0.5];
}

- (void)showPreviousViewController {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Actions
- (void)close {
    [self updateToTakePhoto];
}

#pragma mark - Actions
- (void)cellTap:(UIButton *)button {
    if (_filteredImages.count < button.tag)
        self.imageView.image = [_image performSelector:NSSelectorFromString([@"e" stringByAppendingFormat:@"%d", button.tag]) withObject:nil];
    else
        self.imageView.image = _filteredImages[button.tag-1];
    
}

- (void)next {
    [IGFirstViewController acomplishWithImage:self.imageView.image];
}

@end
