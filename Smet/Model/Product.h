//
//  Product.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <Realm/Realm.h>

@interface Product : RLMObject

@property NSString *producerName;
@property NSString *productImageURL;
@property NSString *ProductPageURL;

@end
RLM_ARRAY_TYPE(Product)
