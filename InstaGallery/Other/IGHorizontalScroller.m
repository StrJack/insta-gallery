//
//  IGHorizontalScroller.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/20/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGHorizontalScroller.h"

@implementation IGHorizontalScroller {
    Class<IGCellProtocol> _cellType;
}

- (id)initWithCellType:(Class<IGCellProtocol>)cellType {
    _cellType = cellType;
    
    self = [super initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, [_cellType cellHeight])];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}


@end
