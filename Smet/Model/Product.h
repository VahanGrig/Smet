//
//  Product.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <Realm/Realm.h>

@interface Product : RLMObject

@property NSInteger id;
@property NSString *producerName;
@property NSString *productImageURLString;
@property NSString *productPageURLString;

+ (Product *)initWithDictionary:(NSDictionary *)dictionary;

@end
RLM_ARRAY_TYPE(Product)
