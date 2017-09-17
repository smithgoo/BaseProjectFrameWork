//
//  AppDelegate.m
//  MainProject
//
//  Created by 王朋 on 2017/4/19.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "AppDelegate.h"
#import <RequestLibApi.h>
#import "GuidePageViewController.h"
#import "MainTabBarController.h"
#import <Bugly/Bugly.h>
#import "AppDelegate+Notification.h"
#import "AppDelegate+MobShare.h"
#import <ShareSDK/ShareSDK.h>
#import <JPUSHService.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()

//qushi
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //配置第三方和基础信息
    [self initGloble:launchOptions];
    
  
    
    BOOL isFirstLoad =[[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLoad"];
    //    if (!isFirstLoad) {
    //        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:[GuidePageViewController new]];
    //        self.window.rootViewController =nav;
    
    //    } else {
    //
    ////    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:[SimpleViewController new]];
    self.window.rootViewController =[MainTabBarController new];
    //    }
    
    return YES;
}


/**
 启动前加载数据处理 推送  闪退检测  网络环境
 */
- (void)initGloble:(NSDictionary *)launchOptions{
    //注册 jpush
    [self registerRemoteNotificationWithLaunchOption:launchOptions];
    
    //微信注册
    [WXApi registerApp:WX_AppID ];
    
    //加载腾讯的闪退监测
    [Bugly startWithAppId:BUGLYKEY];
    
    //初始化网络配置
    [self initializeTheConfiguration];
    
    //配置分享信息
    [self configurationToShareInformation];
    
    
}

//初始化配置
- (void)initializeTheConfiguration {
    // 开启网络监听
    //开始监听网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus allstatus) {
        switch (allstatus) {
            case AFNetworkReachabilityStatusNotReachable:{
                //无网络
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您当前应用没有接入网络，请允许该应用使用网络" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alert show];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                //WiFi
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //移动网络
                break;
            }
            case AFNetworkReachabilityStatusUnknown:{
                //未知网络
                [BMToast makeText:@"未知网络"];
                break;
            }
            default:
                break;
        }
    }];
    
    //请求配置
    [BaseInfo autoRequestCommon];
    // 开启键盘监听
    [BaseInfo startKeyboardManager];
    
    // 初始化弹出框
    [BaseInfo setMessageStyle];
    
    // 配置文件初始化
    [ConfigInfo initialize];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [JPUSHService resetBadge];
    [application setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 支付回调
//微信回调

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                [BaseInfo showErrorMessage:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BussinessPaySuccess" object:nil userInfo:nil];
                
            }else{
                [BaseInfo showErrorMessage:@"支付失败"];
            }
            
        }];
        
    } else {
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [BaseInfo showErrorMessage:@"支付成功"];
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BussinessPaySuccess" object:nil userInfo:nil];
                
            }else{
                [BaseInfo showErrorMessage:@"支付失败"];
            }
        }];
        
        
    } else {
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

#pragma mark - WXApiDelegate
-(void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp*response=(PayResp*)resp;  // 微信终端返回给第三方的关于支付结果的结构体
        
        switch (response.errCode) {
            case WXSuccess:
            {// 支付成功，向BaijiWeixinPay后台发送消息
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_PaySuccess" object:nil];
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                NSLog(@"支付失败");
                [BaseInfo showErrorMessage:@"支付失败"];
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                NSLog(@"取消支付");
                [BaseInfo showErrorMessage:@"取消支付"];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                NSLog(@"发送失败");
                [BaseInfo showErrorMessage:@"发送失败"];
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                NSLog(@"微信不支持");
                [BaseInfo showErrorMessage:@"微信不支持"];
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                NSLog(@"授权失败");
                [BaseInfo showErrorMessage:@"授权失败"];
            }
                break;
            default:
                break;
        }
    }
}







@end
