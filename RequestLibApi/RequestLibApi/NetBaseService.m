//
//  NetBaseService.m
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "NetBaseService.h"
#import "BaseInfo.h"
#import <AFNetworking.h>
#import "NSObject+MJKeyValue.h"
#import "RHSocketCustomRequest.h"

@interface NetBaseService ()
{
    AFHTTPSessionManager *sessionManager;
}

@end

@implementation NetBaseService

+(BOOL)isShowLoadingViewWithURL:(NSString *)url{
    NSArray *filts = @[@"App/User/Slide/left_slide",
                       @"App/User/Slide/right_slide",
                       @"App/User/User/get_report_info",
                       @"App/User/Slide/index",
                       @"App/User/User/get_u_member",
                       @"App/User/Attention/check_rules",
                       @"App/User/User/get_business_info",
                       @"App/User/Personal/business_view",
                       @"App/User/Personal/get_personal_info",
                       @"App/Home/Feed/add_see_time"];
    for (NSString *str in filts) {
        if ([url rangeOfString:str].length != 0) {
            return YES;
        }
    }
    return NO;
}

+ (void)get:(NSString *)url
 parameters:(NSMutableDictionary *)parameters
    success:(void (^)(int code, NSString *msg, id data))success
      error:(void (^)(int code, NSString *msg))error
    failure:(void (^)(NSError *failure))failure
{
    if (![self isShowLoadingViewWithURL:url]) {
        [BaseInfo showLoadingMessage];
    }
    [self request:url parameters:parameters datas:nil method:@"get" success:success error:error failure:failure];
}



+ (void)post:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure
{
    if (![self isShowLoadingViewWithURL:url]) {
        [BaseInfo showLoadingMessage];
    }
    [self request:url parameters:parameters datas:nil method:@"post" success:success error:error failure:failure];
}

+ (void)post:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
       datas:(NSMutableDictionary *)datas
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure
{
    [BaseInfo showLoadingMessage];
    [self request:url parameters:parameters datas:datas method:@"post" success:success error:error failure:failure];
}

+ (void)request:(NSString *)url
     parameters:(NSMutableDictionary *)parameters
          datas:(NSMutableDictionary *)datas
         method:(NSString *)method
        success:(void (^)(int code, NSString *msg, id data))success
          error:(void (^)(int code, NSString *msg))error
        failure:(void (^)(NSError *failure))failure
{
    
#ifdef DEBUG
    NSLog(@"request infomation=============");
    NSLog(@"url:%@", url);
    NSLog(@"parameters:%@", parameters);
    NSLog(@"============");
#endif
    
    //获取请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求以及响应的解析方式
    if (datas != nil && datas.allKeys.count > 0) {
        [manager.requestSerializer setTimeoutInterval:30];
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            for (int i = 0; i < datas.allKeys.count; i++) {
                NSString *key = [datas.allKeys objectAtIndex:i];
                NSData *data = [datas objectForKey:key];
                [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpeg"];
            }
        } success:^(NSURLSessionDataTask *operation, id responseObject) {
             [self doSuccess:operation responseObject:responseObject success:success error:error];
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
             [self doFailure:operation error:error failure:failure];
        }];
    }
    else {
        if ([method isEqualToString:@"get"]) {
            NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
            request.timeoutInterval = 30; //设置超时时间
            NSURLSessionDataTask *task = [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self doSuccess:task responseObject:responseObject success:success error:error];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self doFailure:task error:error failure:failure];
            }];
            [task resume];
        }
        else {
            
            NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
            request.timeoutInterval = 30; //设置超时时间
            NSURLSessionDataTask *task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self doSuccess:task responseObject:responseObject success:success error:error];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self doFailure:task error:error failure:failure];
            }];
            [task resume];
        }
    }
}


+ (void)doSuccess:(NSURLSessionDataTask *)operation
   responseObject:(id)responseObject
          success:(void (^)(int code, NSString *msg, id data))success
            error:(void (^)(int code, NSString *msg))error
{
#ifdef DEBUG
    NSLog(@"responseObject:%@", responseObject);
#endif
    [BaseInfo hideMessage];
    NSDictionary *result = (NSDictionary *)responseObject;
    int code = [[result objectForKey:@"status"] intValue];
    NSString *msg = [result objectForKey:@"msg"];
    if (code == 1) {
        if ([result.allKeys containsObject:@"data"]) {
            id data = [result objectForKey:@"data"];
            success(code, msg, data);
            if ([data isKindOfClass:[NSDictionary class]]) {
                if ([((NSDictionary *)data).allKeys containsObject:@"socket"]) {
                    NSDictionary *socket = data[@"socket"];
                    //连接成功后，发送数据包
                    RHSocketCustomRequest *req = [[RHSocketCustomRequest alloc] init];
                    //阿萨德爱迪生
                    NSString *jsonStr;
                    //Socket发送消息
                    NSError *parseError = nil;
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:socket options:kNilOptions error:&parseError];
                    jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    jsonStr =[NSString stringWithFormat:@"%@\n",jsonStr];
                    NSLog(@"jsonStr =%@ 发送成功", jsonStr);
                    req.object = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSocketPacketRequest object:req];
                }
            }
        }
        else {
            success(code, msg, nil);
        }
    } //验证成功
    else {
        error(code, msg);
    } //验证失败
}

+ (void)doFailure:(NSURLSessionDataTask *)operation error:(NSError *)error failure:(void (^)(NSError *failure))failure
{
    if ([BaseInfo isDebug]) {
        NSLog(@"request failure");
        NSLog(@"operation.request.URL:%@", operation.response.URL);
//        NSLog(@"operation.userInfo:%@", operation.response.userInfo);
        NSLog(@"operation.responseString:%@", operation.response);
        NSLog(@"failure:%@", error);
        NSLog(@" ");
    }
    [BaseInfo hideMessage];
    if (failure) {
        failure(error);
    }
}

+ (void)post_file:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
       datas:(NSMutableDictionary *)datas
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure
{
    [self request_file:url parameters:parameters datas:datas method:@"post" success:success error:error failure:failure];
}

// 上传文件时，文件的名字要以下划线_类型结尾（_jpg, _mp3），以便更改流类型
+ (void)request_file:(NSString *)url
     parameters:(NSMutableDictionary *)parameters
          datas:(NSMutableDictionary *)datas
         method:(NSString *)method
        success:(void (^)(int code, NSString *msg, id data))success
          error:(void (^)(int code, NSString *msg))error
        failure:(void (^)(NSError *failure))failure
{

    if ([BaseInfo isDebug]) {
        NSLog(@"request infomation");
        NSLog(@"url:%@", url);
        NSLog(@"parameters:%@", parameters);
        NSLog(@" ");
    }
    //获取请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (datas != nil && datas.allKeys.count > 0) {
        [manager.requestSerializer setTimeoutInterval:30];
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i = 0; i < datas.allKeys.count; i++) {
                NSString *key = [datas.allKeys objectAtIndex:i];
                NSData *data = [datas objectForKey:key];
                NSString *suffix = [[key componentsSeparatedByString:@"_"] lastObject];
                NSString *prefix = [key substringToIndex:(key.length-suffix.length-1)];
                [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.%@", prefix, suffix] mimeType:suffix];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [self doSuccess:task responseObject:responseObject success:success error:error];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [self doFailure:task error:error failure:failure];
        }];
    }
    else {
        if ([method isEqualToString:@"get"]) {
            NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
            request.timeoutInterval = 30; //设置超时时间
            NSURLSessionDataTask *task= [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self doSuccess:task responseObject:responseObject success:success error:error];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self doFailure:task error:error failure:failure];
            }];
            [task resume];
        }
        else {
            NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
            request.timeoutInterval = 30; //设置超时时间
            NSURLSessionDataTask *task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self doSuccess:task responseObject:responseObject success:success error:error];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self doFailure:task error:error failure:failure];
            }];
            [task resume];
        }
    }
}

+(instancetype)manager{
    static NetBaseService *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetBaseService alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        sessionManager = [AFHTTPSessionManager manager];
        [sessionManager.requestSerializer setTimeoutInterval:30];
    }
    return self;
}

-(AFHTTPSessionManager *)sessionManager{
    return sessionManager;
}

+(void)request:(NSString *)url method:(RequestMethod)method responseObjClass:(Class)clss params:(NSMutableDictionary *)params datas:(NSMutableDictionary *)datas success:(void(^)(NSString *msg, id datas))success failure:(void (^)(NSString *errMsg))failure{
    
    //获取请求对象，对返回数据处理
    void (^successHandle)(int code, NSString *msg, id data) =^(int code, NSString *msg, id data){
        if (clss == nil) {
            success(msg, data);
        }else{
            if ([data isKindOfClass:[NSArray class]]) {
                success(msg, [clss mj_objectArrayWithKeyValuesArray:data]);
            }else{
                id model = [clss mj_objectWithKeyValues:data];
                if (model == nil) {
                    success(msg, data);
                }else{
                    success(msg, model);
                }
            }
        }
    };
    //失败处理
    void (^failureHandle)(int code, NSString *msg) = ^(int code, NSString *errMsg){
        failure(errMsg);
    };
    
    if (datas.allKeys.count > 0) {
        [self updateImage:url params:params datas:datas success:successHandle failure:failureHandle];
    }else{
        AFHTTPSessionManager *manager = [[self manager] sessionManager];
        NSString *method = @"GET";
        if (method == RequestMethodPost) {
            method = @"POST";
        }
        NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:url parameters:params error:nil];
        request.timeoutInterval = 30; //设置超时时间
        
        NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                [self doSuccess:nil responseObject:responseObject success:successHandle error:nil];
            }else{
#ifdef DEBUG
                failure(error.userInfo.description);
#else
                failure(@"网络异常请稍后再试");
#endif
            }
        }];
        [task resume];
    }
}


+(void)updateImage:(NSString *)url params:(NSMutableDictionary*)params datas:(NSMutableDictionary *)datas success:(void (^)(int code, NSString *msg, id data))success failure:(void (^)(int code, NSString *msg))error{
    //上传文件
    AFHTTPSessionManager *manager = [[NetBaseService manager] sessionManager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < datas.allKeys.count; i++) {
            NSString *key = [datas.allKeys objectAtIndex:i];
            NSData *data = [datas objectForKey:key];
            [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self doSuccess:task responseObject:responseObject success:success error:error];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self doFailure:task error:error failure:nil];
    }];
}
@end
