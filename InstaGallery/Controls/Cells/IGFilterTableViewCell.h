//
//  IGFilterTableViewCell.h
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/19/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IGCellProtocol.h"

@interface IGFilterTableViewCell : UITableViewCell <IGCellProtocol>
+ (CGFloat)cellHeight;
+ (CGSize)thumbnailImageSize;
@end
