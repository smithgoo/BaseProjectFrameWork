//
//  NetPayOrderModel.h
//  MainProject
//
//  Created by 王朋 on 2017/5/27.
//  Copyright © 2017年 app_developer@sina.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetPayOrderModel : NSObject
@property (nonatomic,strong) NSString *member_id;//会员ID
@property (nonatomic,strong) NSString *money_total;//金额
@property (nonatomic,strong) NSString *order_no;//订单号
@property (nonatomic,strong) NSString *pay_type;//支付方式1支付宝 2微信
@property (nonatomic,strong) NSString *status;//状态10未支付 20已支付
@property (nonatomic,strong) NSString *type;//1消费，2购买会员3提现

 
//预支付Id
@property (nonatomic, copy) NSString *prepayId;
@property (nonatomic, copy) NSString *wx_pay_id;
@end
