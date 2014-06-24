//
//  IGFilterTableViewCell.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/19/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGFilterTableViewCell.h"

#define CELL_HEIGHT         125.0
#define THUMBNAIL_WIDTH     40.0

@implementation IGFilterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect cellFrame = self.frame;
        cellFrame.size.height = CELL_HEIGHT;
        
        self.frame = cellFrame;
    }
    return self;
}

+ (CGFloat)cellHeight {
    return CELL_HEIGHT;
}

+ (CGSize)thumbnailImageSize {
    return CGSizeMake(THUMBNAIL_WIDTH, THUMBNAIL_WIDTH);
}

@end
