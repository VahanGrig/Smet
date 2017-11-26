//
//  ResuestManager.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/25/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "RequestManager.h"

static NSString * const baseUrl = @"http://termbin.com/";

@implementation RequestManager

+ (instancetype)manager {
    static RequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RequestManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        
    });
    return instance;
}

- (void)getCategoriesWithCompletion:(Completion)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:@"http://termbin.com/a3rf" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
     
    }];
}

@end
