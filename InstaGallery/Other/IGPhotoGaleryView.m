//
//  IGPhotoGaleryView.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/24/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGPhotoGaleryView.h"

#define NUM_IMAGES_IN_ROW                   4
#define IMAGE_PADDING                       3.0

#define IMAGE_WIDTH (SCREEN_WIDTH - (NUM_IMAGES_IN_ROW+1)*IMAGE_PADDING) / NUM_IMAGES_IN_ROW

@interface IGPhotoGaleryView()

@property(nonatomic, weak) id <IGPhotoGaleryDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) UIView *contentView;

@end

@implementation IGPhotoGaleryView {
    NSMutableArray *_images;
    unsigned int _imagesCount;
}

- (id)initWithFrame:(CGRect)frame andDelegate:(id<IGPhotoGaleryDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        
        self.images = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
        
        self.contentView = [[UIView alloc] initWithFrame:(CGRectMake(0.0, 0.0, SCREEN_WIDTH, 1000))];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.contentView];
        [self setContentSize:self.contentView.bounds.size];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self initializeGalery];
        });
        
    }
    return self;
}

- (void)addPhoto:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0.0, 0.0, IMAGE_WIDTH, IMAGE_WIDTH))];
    imageView.tag = [self.images count];
    imageView.userInteractionEnabled = YES;
    imageView.gestureRecognizers = @[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTappedAtIndex:)]];
    
    imageView.center = CGPointMake((IMAGE_PADDING + IMAGE_WIDTH) * (self.images.count % NUM_IMAGES_IN_ROW) + IMAGE_WIDTH/2.,
                                   (self.images.count / NUM_IMAGES_IN_ROW) * (IMAGE_WIDTH + IMAGE_PADDING) + IMAGE_WIDTH/2);
    
    imageView.image = image;
    
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setBorderWidth:2.0];
    [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [self resizeContent:imageView];
    
    [self.images addObject:image];
    [self.contentView addSubview:imageView];
    
}

- (void)imageTappedAtIndex:(UITapGestureRecognizer *)sender {
    [self initializeGaleryInIndex:sender.view.tag withCompletionBlock:^(UIImage *image) {
        [self.delegate gotImageFromLibrary:image];
    }];
}

- (void)resizeContent:(UIView *)lastView {
    CGRect contentViewFrame = self.contentView.frame;
    CGRect viewFrame = lastView.frame;
    
    if (viewFrame.origin.y + viewFrame.size.height > contentViewFrame.size.height)
        contentViewFrame.size.height = viewFrame.origin.y + viewFrame.size.height;
    
    [self.contentView setFrame:contentViewFrame];
    [self setContentSize:self.contentView.bounds.size];
}

- (void)initializeGalery {
    [self initializeGaleryInIndex:-1 withCompletionBlock:nil];
}

- (void)initializeGaleryInIndex:(NSInteger)inIndex withCompletionBlock:(void(^)(UIImage *))completion{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                 usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                     if (nil != group) {
                                         // be sure to filter the group so you only get photos
                                         [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                         
                                         NSRange range = inIndex == -1 ? NSMakeRange(1, group.numberOfAssets - 1) : NSMakeRange(group.numberOfAssets - inIndex - 1, 1);
                                         [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]
                                                                 options:NSEnumerationReverse
                                                              usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                                  if (nil != result) {
                                                                      if (inIndex == -1) {
                                                                          UIImage *thumbnail = [UIImage imageWithCGImage:[result thumbnail]];
                                                                          
                                                                          dispatch_sync(dispatch_get_main_queue(), ^{
                                                                              [self addPhoto:thumbnail];
                                                                          });
                                                                      } else {
                                                                          UIImage *image = [UIImage imageWithCGImage:[result defaultRepresentation].fullResolutionImage];
                                                                          completion(image);
                                                                      }
                                                                      
                                                                  }
                                                              }];
                                     }
                                     
                                     *stop = YES;
                                 } failureBlock:^(NSError *error) {
                                     NSLog(@"error: %@", error);
                                 }];
}

@end
