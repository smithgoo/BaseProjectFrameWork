//
//  NetBaseService.h
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestMethod){
    RequestMethodPost = 0,
    RequestMethodGet
};

@interface NetBaseService : NSObject

+ (void)get:(NSString *)url
 parameters:(NSMutableDictionary *)parameters
    success:(void (^)(int code, NSString *msg, id data))success
      error:(void (^)(int code, NSString *msg))error
    failure:(void (^)(NSError *failure))failure __deprecated_msg("Use `request:mehtod:responseObjcClass:params:datas:success:failure:`");

+ (void)post:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure __deprecated_msg("Use `request:mehtod:responseObjcClass:params:datas:success:failure:`");

+ (void)post:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
       datas:(NSMutableDictionary *)datas
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure __deprecated_msg("Use `request:mehtod:responseObjcClass:params:datas:success:failure:`");

+ (void)post_file:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
       datas:(NSMutableDictionary *)datas
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure;

#pragma mark - 修改



/**
 网络请求

 @param url 请求地址
 @param method 请求方式
 @param clss 服务器响应数据对应的 model 类，使用 "NSObject+MJKeyValue.h" 解析
             由于不同接口返回的数据格式可能存在差异，无法解析出对应的 model 需要自己解析，当传 nil 时，返回 data 内原数据
 @param params 请求参数可空
 @param datas 上传图片字典，为 nil 时为普通 http 请求
 @param success 成功回调
 @param failure 失败回调
 */
+(void)request:(NSString *)url method:(RequestMethod)method responseObjClass:(Class)clss params:(NSMutableDictionary *)params datas:(NSMutableDictionary *)datas success:(void(^)(NSString *msg, id datas))success failure:(void (^)(NSString *errMsg))failure;
@end




