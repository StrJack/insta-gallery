//
//  IGFilterScrollerViewCell.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/20/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGFilterScrollerViewCell.h"

#define CELL_PADDING        5
#define CELL_WIDTH          74
#define CELL_HEIGHT         104

#define THUMBNAIL_WIDTH     64.0

@interface IGFilterScrollerViewCell()

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *label;

@end

@implementation IGFilterScrollerViewCell

- (id)initWithThumbnail:(UIImage *)image text:(NSString *)text {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, CELL_WIDTH, CELL_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat thumbnailSideLength = CELL_WIDTH - 2*CELL_PADDING;
        self.thumbnail = [[UIImageView alloc] initWithFrame:(CGRectMake(CELL_PADDING, CELL_PADDING, thumbnailSideLength, thumbnailSideLength))];
        self.thumbnail.image = image;
        [self addSubview:self.thumbnail];
        
        self.label = [[UILabel alloc] initWithFrame:(CGRectMake(0.0, 0.0, CELL_WIDTH, 20.0))];
        self.label.center = CGPointMake(CELL_WIDTH/2, CELL_HEIGHT - 3*CELL_PADDING);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.text = text;
        [self addSubview:self.label];
        
    }
    return self;
}

+ (CGFloat)cellWidth {
    return CELL_WIDTH;
}

+ (CGFloat)cellHeight {
    return CELL_HEIGHT;
}

+ (CGSize)thumbnailImageSize {
    return CGSizeMake(THUMBNAIL_WIDTH, THUMBNAIL_WIDTH);
}

@end
