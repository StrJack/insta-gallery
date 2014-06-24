//
//  Header.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/20/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

@protocol IGCellProtocol

+ (CGFloat)cellHeight;
+ (CGSize)thumbnailImageSize;

@optional
+ (CGFloat)cellWidth;

@end
