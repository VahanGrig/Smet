//
//  ResuestManager.h
//  Smet
//
//  Created by Vahan Grigoryan on 11/25/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^Completion)(id result);
typedef void (^Failed)(id result);

@interface RequestManager : AFHTTPSessionManager

+ (instancetype)manager;
- (void)getCategoriesWithCompletion:(Completion)completion;

@end
