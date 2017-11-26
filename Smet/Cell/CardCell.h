//
//  CardCell.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/27/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UICollectionViewCell

@property (nonatomic) UILabel *cardName;

- (void)initWithCardName:(NSString *)cardName;

@end
