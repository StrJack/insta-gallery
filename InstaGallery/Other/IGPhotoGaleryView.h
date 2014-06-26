//
//  IGPhotoGaleryView.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/24/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IGPhotoGaleryDelegate

- (void)gotImageFromLibrary:(UIImage *)image;

@end

@interface IGPhotoGaleryView : UIScrollView

- (id)initWithFrame:(CGRect)frame andDelegate:(id<IGPhotoGaleryDelegate>)delegate;

@end
