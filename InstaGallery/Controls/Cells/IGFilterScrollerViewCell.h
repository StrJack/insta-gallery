//
//  IGFilterScrollerViewCell.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/20/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGCellProtocol.h"

@interface IGFilterScrollerViewCell : UIView <IGCellProtocol>

- (id)initWithThumbnail:(UIImage *)image text:(NSString *)text;
+ (CGSize)thumbnailImageSize;

@end
