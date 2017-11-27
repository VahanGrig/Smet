//
//  LikedProducts.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/27/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <Realm/Realm.h>

@interface LikedProduct : RLMObject

@property NSInteger id;
@property NSString *productName;

@end
RLM_ARRAY_TYPE(LikedProduct)
