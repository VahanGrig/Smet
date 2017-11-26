//
//  Card.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <Realm/Realm.h>

@interface Card : RLMObject

@property NSString *cardName;
@property NSInteger cardNumber;
@property NSInteger order;

@end
RLM_ARRAY_TYPE(Card)
