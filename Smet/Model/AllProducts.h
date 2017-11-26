//
//  AllProducts.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <Realm/Realm.h>
#import "Product.h"

@interface AllProducts : RLMObject

@property NSInteger id;
@property RLMArray <Product> *products;

@end
