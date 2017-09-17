//
//  ConstInfo.h
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#pragma mark - Notification

#define NOTICE_PlanSummaryRefresh @"NOTICE_PlanSummaryRefresh"

#define NOTICE_ProjectProcessRefresh @"NOTICE_ProjectProcessRefresh"

#pragma mark - System Define

#define App_User_Id     [ConfigInfo appUserId]
#define App_Employee_Id [ConfigInfo appEmployeeId]

#pragma mark - Block

typedef void (^VoidBlock)();
typedef BOOL (^BoolBlock)();
typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);

#pragma mark - AppDelegate

#define KMSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark - Message

#define MSG_LOAD_GET          @"正在加载"
#define MSG_LOAD_GET_SUC      @"加载成功"
#define MSG_LOAD_SET          @"正在执行"
#define MSG_LOAD_SET_SUC      @"执行成功"
#define MSG_ALERT_LIST_EMPTY  @"暂无数据"
#define MSG_ALERT_NET_FAILURE @"服务器内部异常，请稍后重试"

#pragma mark - NetWorkAddress


// 正式地址
#define API_BASE @""
//测试端口
#define kPort 8282

#define WebViewBaseURL @""


// MobSdk
#define MobSdkId @"iosv1101"

//微博 appkey
#define SinaappKey @"568898243"

#define SinaappSecret @"38a4f8204cc784f81f9f0daaf31e02e3"

#define SinaappURL @"http://www.sharesdk.cn"
//微信 appkey
#define WeChartappKey @"wx4868b35061f87885"

#define WeChartappSecret @"64020361b8ec4c99936c0e3999a9f249"

//QQ appkey
#define QQappKey @"100371282"

#define QQappSecret @"aed9b0303e3ed1e27bae87c33761161d"

//极光推送的 key
#define jpush_app_key @"71e8be0db41516ddef07afbc"

//腾讯 bugly key

#define BUGLYKEY @"d954aaa329"

#define User_key @"MDAwMDAwMDAwMIS3hWmEjZJofd2Dq4K5cWWvnnJ2"
