//
//  CardCell.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/27/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (void)initWithCardName:(NSString *)cardName {
    self.cardName = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMidY(self.bounds) - 10, CGRectGetWidth(self.bounds) - 12, 20)];
    [self.cardName setFont:[UIFont boldSystemFontOfSize:17]];
    [self.cardName setTextColor:[UIColor blueColor]];
    [self.cardName setTextAlignment:NSTextAlignmentCenter];
    [self.cardName setText:cardName];
    [self addSubview:self.cardName];
}

- (void)prepareForReuse {
    [self.cardName removeFromSuperview];
    self.cardName = nil;
}

@end
