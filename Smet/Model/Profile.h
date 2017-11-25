//
//  Profile.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <Realm/Realm.h>
#import "Product.h"

@interface Profile : RLMObject

@property RLMArray <Product> *products;
@property NSString *emaleString;
@property NSString *passwordString;
@property NSString *isLogged;
@property NSString *profileID;

@end
RLM_ARRAY_TYPE(Profile)

