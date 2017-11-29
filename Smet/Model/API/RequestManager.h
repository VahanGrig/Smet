//
//  ResuestManager.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/25/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^Completion)(id result);
typedef void (^Failer)(id result);

@interface RequestManager : AFHTTPSessionManager

+ (instancetype)manager;
- (void)getCategoriesWithCompletion:(Completion)completion failer:(Failer)failer;

@end
