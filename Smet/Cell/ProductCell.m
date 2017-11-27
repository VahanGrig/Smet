//
//  ProductCell.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "ProductCell.h"

@interface ProductCell ()

@property (nonatomic) UILabel *productNameLabel;
@property (nonatomic) UIButton *likeButton;
@property (nonatomic) UIView *lineView;

@end

@implementation ProductCell

- (void)initCellForLiked:(BOOL)isliked {
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, CGRectGetWidth(self.bounds) - 24, CGRectGetHeight(self.bounds) - 96)];
   
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 12, CGRectGetWidth(self.bounds), 1)];
    [self.lineView setBackgroundColor:[UIColor lightGrayColor]];
    
    self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.imageView.frame) + 24, CGRectGetWidth(self.bounds) - 68, 20)];
    [self.productNameLabel setText:self.productName];
    [self.productNameLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    self.likeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productNameLabel.frame) + 12, CGRectGetMaxY(self.imageView.frame) + 12, 44, 44)];
    [self.likeButton setImage:[UIImage imageNamed:isliked ? @"fill_heart" : @"heart"] forState:UIControlStateNormal];
    [self.likeButton setImageEdgeInsets:UIEdgeInsetsMake(11, 10, 11, 10)];
    [self.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.imageView];
    [self addSubview:self.lineView];
    [self addSubview:self.productNameLabel];
    [self addSubview:self.likeButton];
}

- (void)prepareForReuse {
    [self.imageView removeFromSuperview];
    [self.lineView removeFromSuperview];
    [self.productNameLabel removeFromSuperview];
    [self.likeButton removeFromSuperview];
    
    self.imageView = nil;
    self.lineView = nil;
    self.productNameLabel = nil;
    self.likeButton = nil;
}

- (void)likeButtonPressed:(UIButton *)sender {
    if (self.likePressed) {
        self.likePressed();
    }
}

@end
