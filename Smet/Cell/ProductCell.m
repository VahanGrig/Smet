//
//  ProductCell.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)initViewImageView {
    self.imageView = [UIImageView new];
    self.imageView.frame = self.bounds;
    [self addSubview:self.imageView];
}

- (void)prepareForReuse {
    [self.imageView removeFromSuperview];
    self.imageView = nil;
}

@end
