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
@property (nonatomic, copy) void (^likePressed)(void);

- (void)initCellForLiked:(BOOL)isliked;

@end
