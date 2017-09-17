//
//  BaijiWeixinPay.h
//  BaiJi
//
//  Created by cnsunrun on 17/4/19.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaijiWeixinPay : NSObject

//支付金额
@property (nonatomic, copy) NSString *money;
//订单号
@property (nonatomic, copy) NSString *orderNum;
//body信息
@property (nonatomic, copy) NSString *bodyContent;
//预支付Id
@property (nonatomic, copy) NSString *prepayId;

@property (nonatomic, copy) NSString *callBackString;

//支付成功监听
//支付成功之后，由AppDelegate里面的微信回调方法 onResp 发送消息到此页面
//支付失败，在AppDelegate里的方法 onResp 直接弹窗显示
@property (nonatomic, copy) void (^listenAliPaySuccess)();

//调用支付方法
- (void)payWXMethod;

@end
