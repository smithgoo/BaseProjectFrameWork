//
//  BaijiWeixinPay.m
//  BaiJi
//
//  Created by cnsunrun on 17/4/19.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "BaijiWeixinPay.h"
#import "getIPhoneIP.h"
#import "XMLDictionary.h"
#import "DataMD5.h"
#import "WXApi.h"

@implementation BaijiWeixinPay

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXPaySuccess) name:@"WX_PaySuccess" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 注册通知方法
- (void)WXPaySuccess
{
    //回调支付成功方法
    if (self.listenAliPaySuccess) {
        self.listenAliPaySuccess();
    }
}



#pragma mark - 微信支付相关方法
- (void)payWXMethod {
    NSString *appid,*mch_id,*nonce_str,*sign,*body,*out_trade_no,*total_fee,*spbill_create_ip,*notify_url,*trade_type,*partner;
    //应用APPID
    appid = WX_AppID;
    //微信支付商户号
    mch_id = MCH_ID;
    //产生随机字符串，这里最好使用和安卓端一致的生成逻辑
    nonce_str =[self generateTradeNO];
    //微信支付信息
    body = self.bodyContent;
    //从自己服务器获取的订单号
    out_trade_no = self.orderNum;
    //交易价格1表示0.01元，10表示0.1元
    total_fee = self.money;
    //获取本机IP地址，请再wifi环境下测试，否则获取的ip地址为error，正确格式应该是8.8.8.8
    spbill_create_ip =[getIPhoneIP getIPAddress];
    //交易结果通知网站
    notify_url = APP_WXCallback_url;
    trade_type =@"APP";
    //商户密钥
    partner = WX_partnerKey;
    //获取sign签名
    DataMD5 *data = [[DataMD5 alloc] initWithAppid:appid mch_id:mch_id nonce_str:nonce_str partner_id:partner body:body out_trade_no:out_trade_no total_fee:total_fee spbill_create_ip:spbill_create_ip notify_url:notify_url trade_type:trade_type];
    sign = [data getSignForMD5];
    //设置参数并转化成xml格式
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:appid forKey:@"appid"];//公众账号ID
    [dic setValue:mch_id forKey:@"mch_id"];//商户号
    [dic setValue:nonce_str forKey:@"nonce_str"];//随机字符串
    [dic setValue:sign forKey:@"sign"];//签名
    [dic setValue:body forKey:@"body"];//商品描述
    [dic setValue:out_trade_no forKey:@"out_trade_no"];//订单号
    [dic setValue:total_fee forKey:@"total_fee"];//金额
    [dic setValue:spbill_create_ip forKey:@"spbill_create_ip"];//终端IP
    [dic setValue:notify_url forKey:@"notify_url"];//通知地址
    [dic setValue:trade_type forKey:@"trade_type"];//交易类型

    PayReq *request = [[PayReq alloc] init];
    request.openID = [dic objectForKey:@"appid"];
    request.partnerId = [dic objectForKey:@"mch_id"];
    request.prepayId= self.prepayId;
    request.package = @"Sign=WXPay";
    request.nonceStr= [dic objectForKey:@"nonce_str"];
    //将当前事件转化成时间戳
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    UInt32 timeStamp =[timeSp intValue];
    request.timeStamp= timeStamp;
    // 签名加密
    DataMD5 *md5 = [[DataMD5 alloc] init];
    request.sign=[md5 createMD5SingForPay:request.openID partnerid:request.partnerId prepayid:request.prepayId package:request.package noncestr:request.nonceStr timestamp:request.timeStamp];
    // 调用微信
    [WXApi sendReq:request];
    
    
    
    
    // 转换成xml字符串
//    NSString *string = [dic XMLString];
//    [self http:string];
}

#pragma mark - 产生随机订单号
- (NSString *)generateTradeNO {
    static int kNumber = 15;
    
    NSString *sourceStr = WX_nonceStr;
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0)); // 此行代码有警告:
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
