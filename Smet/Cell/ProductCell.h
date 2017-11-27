//
//  ProductCell.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSString *productName;
@property (nonatomic) NSInteger productId;
@property (nonatomic) BOOL isLiked;
@property (nonatomic, copy) BOOL (^likePressed)(NSString *productName, NSInteger productId);

- (void)initCell;

@end
