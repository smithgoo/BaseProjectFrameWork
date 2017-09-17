//
//  JLNetworkManager.m
//  AFNdemo
//
//  Created by mc on 16/9/3.
//  Copyright © 2016年 IdeaFactory. All rights reserved.
//

#import "JLNetworkManager.h"


@protocol NetworkToolsProxy <NSObject>
@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end


static NSMutableArray *tasks;
static NSTimeInterval _timeout = 60.0f;
static NSDictionary *_httpHeaders = nil;
static JLResponseType _responseType = JLResponseTypeJSON;
static JLRequestType  _requestType  = JLRequestTypeJSON;

@interface JLNetworkManager ()<NetworkToolsProxy>

@end

@implementation JLNetworkManager

+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

/**
 *  设置超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout {

    _timeout = timeout;
}

+ (void)configRequestType:(JLRequestType)requestType
             responseType:(JLResponseType)responseType {

    _requestType = requestType;
    _responseType = responseType;
}

/**
 *  设置请求头
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {

    _httpHeaders = httpHeaders;
}

/// 提供单利类
+ (instancetype)sharedNetworkManager {

    JLNetworkManager *instance = [self GetNetworkManager];
    instance.requestSerializer.timeoutInterval = _timeout;
    
    switch (_requestType) {
        case JLRequestTypeJSON: {
            instance.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        case JLRequestTypePlainText: {
            instance.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
    }
    
    switch (_responseType) {
        case JLResponseTypeJSON: {
            instance.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case JLResponseTypeXML: {
            instance.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case JLResponseTypeData: {
            instance.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
    }
    
    instance.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                               @"text/html",
                                                                               @"text/json",
                                                                               @"text/plain",
                                                                               @"text/javascript",
                                                                               @"text/xml",
                                                                               @"image/*"]];
    
    for (NSString *key in _httpHeaders.allKeys) {
        if (_httpHeaders[key] != nil) {
            [instance.requestSerializer setValue:_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    return instance;
}

+ (instancetype)GetNetworkManager {

    static JLNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:JLBaseUrl] sessionConfiguration:nil];
        instance.securityPolicy.allowInvalidCertificates = YES;
        instance.operationQueue.maxConcurrentOperationCount = 6;
//        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        policy.allowInvalidCertificates = NO;
        [policy setValidatesDomainName:NO];
        instance.securityPolicy = policy;
    });
    return instance;
}

+ (void)postWithUrl:(NSString *)url parameter:(NSDictionary *)parameter completeBlock:(JLRequestCallBack)complete
{
    NSArray *allKeys = [parameter allKeys];
    NSArray *allValues = [parameter allValues];
    NSString *paramStr = [[NSString alloc] init];
    for (int i = 0; i < allValues.count; i++) {
        NSString *key = allKeys[i];
        NSString *value = allValues[i];
        paramStr = [[[paramStr stringByAppendingString:key] stringByAppendingString:@"="] stringByAppendingString:value];
        if (i != allValues.count - 1) {
            paramStr = [paramStr stringByAppendingString:@"&"];
        }
    }
    paramStr = [paramStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *postBody=[NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"%@",paramStr] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *urls = [[NSURL alloc]initWithString:url];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:urls
                                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                         timeoutInterval:20.0f];
    [request setHTTPMethod: @"POST"];
    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postBody];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            complete(dict,error);
        }
    }];
    
    [dataTask resume];
}

- (JLURLSessionTask *)requestWithMethod:(RequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(JLRequestCallBack)finished {

    if (URLString.length <= 0) {
        return nil;
    }
    
    __block BOOL networkConnect = YES;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                networkConnect = NO;
                break;
            default:
                break;
        }
    }];
    
    //没有网络
    if (!networkConnect) {
        finished(nil,[NSError errorWithDomain:@"网络无法连接" code:-9999 userInfo:nil]);
        return nil;
    }
    
    NSString *url=[NSURL URLWithString:URLString] ? URLString : [self strUTF8Encoding:URLString];
    NSString *methodName = nil;
    switch (method) {
        case GET: {
            methodName = @"GET";
            break;
        }
        case POST: {
            methodName = @"POST";
            break;
        }
        case HEAD: {
            methodName = @"HEAD";
            break;
        }
        case PUT: {
            methodName = @"PUT";
            break;
        }
        case PATCH: {
            methodName = @"PATCH";
            break;
        }
        case DELETE: {
            methodName = @"DELETE";
            break;
        }
    }
    

    
    NSURLSessionDataTask * sessionDataTask = [[JLNetworkManager sharedNetworkManager] dataTaskWithHTTPMethod:methodName URLString:url parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObjet) {
        if (responseObjet) {
            finished([self tryToParseData:responseObjet],nil);
        }
        if ([tasks containsObject:sessionDataTask]) [tasks removeObject:sessionDataTask];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",task.response);
        finished(nil, error);
        if ([tasks containsObject:sessionDataTask]) [tasks removeObject:sessionDataTask];
    }];
    [sessionDataTask resume];
    
    if (sessionDataTask && (![tasks containsObject:sessionDataTask])) {
        [tasks addObject:sessionDataTask];
    }
    
    return sessionDataTask;
}



- (NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
}

- (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    NSString *baseUrl = [[JLNetworkManager sharedNetworkManager] baseURL].absoluteString;
    if (baseUrl == nil || [baseUrl length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if ([baseUrl hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               baseUrl, mutablePath];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",baseUrl, path];
            }
        } else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",baseUrl, path];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               baseUrl, path];
            }
        }
    }
    
    return absoluteUrl;
}


- (JLURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary *)parameters
                             progress:(JLProgressStatus)progress
                             finished:(JLRequestCallBack)finished {

    if ([[JLNetworkManager sharedNetworkManager] baseURL] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[JLNetworkManager sharedNetworkManager] baseURL], url]] == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    
    NSString *absoluteUrl = [self absoluteUrlWithPath:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setValidatesDomainName:NO];
    manager.securityPolicy = policy;
    JLURLSessionTask *session = [manager POST:absoluteUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([tasks containsObject:task]) [tasks removeObject:task];
        if (finished) {
            finished([self tryToParseData:responseObject],nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([tasks containsObject:task]) [tasks removeObject:task];
        
        if (finished) {
            finished(nil,error);
        }
        
    }];
    
    [session resume];
    if (session && (![tasks containsObject:session])) {
        [tasks addObject:session];
    }
    
    return session;
}

/**
 *	上传文件操作
 *
 *	@param url						上传路径
 *	@param uploadingFile	待上传文件的路径
 *	@param progress			上传进度
 */
- (JLURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                               progress:(JLProgressStatus)progress
                               finished:(JLRequestCallBack)finished {

    if ([NSURL URLWithString:uploadingFile] == nil) {
        NSLog(@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在");
        return nil;
    }
    
    NSURL *uploadURL = nil;
    if ([[JLNetworkManager sharedNetworkManager] baseURL] == nil) {
        uploadURL = [NSURL URLWithString:url];
    } else {
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[JLNetworkManager sharedNetworkManager] baseURL].absoluteString, url]];
    }
    
    if (uploadURL == nil) {
        NSLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
        return nil;
    }
    
    AFHTTPSessionManager *manager = [JLNetworkManager sharedNetworkManager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    JLURLSessionTask *session = [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if ([tasks containsObject:session]) [tasks removeObject:session];
        if (finished) {
            if (error) {
                finished(nil,error);
            }else {
                finished([self tryToParseData:responseObject],nil);
            }
        }
    }];
    
    if (session &&(![tasks containsObject:session])) [tasks addObject:session];
    
    return session;

}


/*!
 *  下载文件
 *
 *  @param url           下载URL
 *  @param saveToPath    下载到哪个路径下
 *  @param progressBlock 下载进度
 */
- (JLURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(JLProgressStatus)progressBlock
                             finished:(JLRequestCallBack)finished {

    
    if ([[JLNetworkManager sharedNetworkManager] baseURL] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[JLNetworkManager sharedNetworkManager] baseURL].baseURL, url]] == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    JLNetworkManager *manager = [JLNetworkManager sharedNetworkManager];
    
    JLURLSessionTask *session = nil;
    
    session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if ([tasks containsObject:session]) [tasks removeObject:session];
        
        if (finished) {
            
            if (error) {
                finished(nil,error);
            }else {
            
                finished(filePath.absoluteString,nil);
            }
        }
    }];
    
    [session resume];
    if (session && (![tasks containsObject:session])) {
        [tasks addObject:session];
    }
    
    return session;
}

- (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

@end
