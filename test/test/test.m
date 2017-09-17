//
//  test.m
//  test
//
//  Created by 王朋 on 2017/4/19.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "test.h"
#import "AFNetworking.h"
@implementation test
+ (void)sayHello {

    NSLog(@"hello world");
}

+ (void)requestsuccess:(void(^)(NSString* str))success faile:(void(^)(NSString*str))faile {
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    [manager GET:nil parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

@end
