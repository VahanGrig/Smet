//
//  Product.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (Product *)initWithDictionary:(NSDictionary *)dictionary {
    Product *newProduct = [Product new];
    
    if (dictionary[@"url"]) {
        NSString *string = dictionary[@"url"];
        NSMutableString *productString = string.mutableCopy;
        if ([productString hasPrefix:@"http://dev.m."]) {
            [productString replaceCharactersInRange:NSMakeRange(0, [@"http://dev.m." length]) withString:@"http:"];
        }
        newProduct.productPageURLString = productString;
    }
    if (dictionary[@"coverUrl"]) {
        newProduct.productImageURLString = [NSString stringWithFormat:@"http:%@", dictionary[@"coverUrl"]];
    }
    if (dictionary[@"producer"][@"name"]) {
        newProduct.producerName = dictionary[@"producer"][@"name"];
    }
    if (dictionary[@"id"]) {
        NSNumber *idNumber = dictionary[@"id"];
        newProduct.id = [idNumber integerValue];
    }
    return newProduct;
}

+ (NSString *)primaryKey {
    return @"id";
}

@end
