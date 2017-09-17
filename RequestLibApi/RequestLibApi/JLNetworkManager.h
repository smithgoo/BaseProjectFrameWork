//
//  JLNetworkManager.h
//  AFNdemo
//
//  Created by mc on 16/9/3.
//  Copyright © 2016年 IdeaFactory. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


/**
 *  这里配置根URL
 */
#define JLBaseUrl @"https://www.ddb.pub/app_ddb/v3/"

typedef NS_ENUM(NSUInteger, JLResponseType) {
    JLResponseTypeJSON = 1, // 默认
    JLResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    JLResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, JLRequestType) {
    JLRequestTypeJSON = 1, // 默认
    JLRequestTypePlainText  = 2 // 普通text/html
};

typedef void (^JLProgressStatus)(int64_t currentBytes,
                                    int64_t totalBytes);

typedef NS_ENUM(NSUInteger, RequestMethod) {
    GET,
    POST,
    HEAD,
    PUT,
    PATCH,
    DELETE
};

// 请勿直接使用NSURLSessionDataTask,以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionTask JLURLSessionTask;

/**
 *  请求结果block
 */
typedef void(^JLRequestCallBack)(id result, NSError *error);

@interface JLNetworkManager : AFHTTPSessionManager

/// 提供单利类
+ (instancetype)sharedNetworkManager;

/**
 *  设置超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout;

/**
 *  设置请求/接收类型
 */
+ (void)configRequestType:(JLRequestType)requestType
             responseType:(JLResponseType)responseType;

/**
 *  设置请求头
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;


+ (void)postWithUrl:(NSString *)url parameter:(NSDictionary *)parameter completeBlock:(JLRequestCallBack)complete;

/**
 *  网络请求
 *
 *  @param method     请求方式
 *  @param URLString  url
 *  @param parameters 参数
 *  @param finished   请求回调
 *
 *  @return 返回请求任务对象,方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
- (JLURLSessionTask *)requestWithMethod:(RequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(JLRequestCallBack)finished;


/**
 *	图片上传接口，若不指定baseurl，可传完整的url
 *
 *	@param image			图片对象
 *	@param url				上传图片的接口路径，如/path/images/
 *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *	@param name				与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *	@param mimeType		默认为image/jpeg
 *	@param parameters	参数
 *	@param progress		上传进度

 */
- (JLURLSessionTask *)uploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(JLProgressStatus)progress
                               finished:(JLRequestCallBack)finished;

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
                                 finished:(JLRequestCallBack)finished;


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
                               finished:(JLRequestCallBack)finished;

@end
