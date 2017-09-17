//
//  BaijiAliPay.h
//  BaiJi
//
//  Created by cnsunrun on 17/4/19.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaijiAliPay : NSObject
//支付金额
@property (nonatomic, copy) NSString *money;
//订单号
@property (nonatomic, copy) NSString *orderNum;
//body内容
@property (nonatomic, copy) NSString *bodyContent;
//subject内容
@property (nonatomic, copy) NSString *subjectContent;
//支付成功监听
@property (nonatomic, copy) void (^listenAliPaySuccess)();
//支付失败监听
@property (nonatomic, copy) void (^listenAliPayFailure)();

@property (nonatomic, copy) NSString *callBackString;

//支付宝充值
- (void)payZFBMethod;


@end
