//
//  Profile.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <Realm/Realm.h>
#import "Card.h"

@interface Profile : RLMObject

@property NSInteger id;
@property RLMArray <Card> *cards;
@property NSString *emaleString;
@property NSString *passwordString;
@property NSString *isLogged;
@property NSString *profileID;

@end
RLM_ARRAY_TYPE(Profile)

