//
//  IGBasePicturedButton.m
//  InstaGallery
//
//  Created by Eugene Stroganov on 6/23/14.
//  Copyright (c) 2014 Test Organization. All rights reserved.
//

#import "IGBasePicturedButton.h"

#define flButtonSide                36.0f
#define flSideInset                 4.0f
#define flButtonImageSide           36.0f

@implementation IGBasePicturedButton

- (id)init {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, flButtonSide, flButtonSide)];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setImage:[UIImage imageNamed:[self buttonImageName]] forState:(UIControlStateNormal)];
        
        [self makeImageInsets];
    }
    return self;
}

- (UIImage *)makeBrighter {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:[self buttonImageName]]];
    
    CIFilter *filter= [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputBrightness"];
    
    return [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
}

- (void)makeImageInsets {
    [self setImageEdgeInsets:UIEdgeInsetsMake(flSideInset, flSideInset, flSideInset, flSideInset)];
}

- (NSString *)buttonImageName {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
