//
//  HomePageViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/20.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "HomePageViewController.h"
#import <RequestLibApi/NetBaseService.h>
#import "AppDelegate+MobShare.h"
#import "PublicAboutUsViewController.h"
#import "NetPayOrderModel.h"
#import "NetUserService.h"
#import <CardIO.h>
@interface HomePageViewController ()<CardIOViewDelegate>
@property (nonatomic,assign) int payFlag;
@property (nonatomic,strong) NSString *moneyStr;
@property (nonatomic,strong) NetPayOrderModel *payOrderModel;
@property (nonatomic,strong) BaijiAliPay *aliPay;
@property (nonatomic,strong) BaijiWeixinPay *weixinPay;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@end

@implementation HomePageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _payOrderModel =[NetPayOrderModel new];
    // Do any additional setup after loading the view from its nib.
    
    CardIOView *cardView =[[CardIOView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_weixinBtn.frame)+10, km_screen_width, 200)];
    cardView.delegate =self;
    [self.view addSubview:cardView];
    [NetBaseService request:@"http://test.cnsunrun.com/yidaigouliang/App/Home/Detailed/get_dog_detailed?member_id=535&p=1&times=&type=&user_type=3" method:RequestMethodGet responseObjClass:nil params:nil datas:nil success:^(NSString *msg, id data) {
        
    } failure:^(NSString *errMsg) {
        
    }];
}

- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)info {
    if (info) {
        // The full card number is available as info.cardNumber, but don't log that!
        NSLog(@"银行卡 卡号：%@",info.cardNumber);
        //        NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv);
        // Use the card info...
    }
    else {
        NSLog(@"User cancelled payment info");
        // Handle user cancellation here...
    }
    
    [cardIOView removeFromSuperview];
}


- (IBAction)weixinPay:(UIButton *)sender {
    
    [self makeSureToPay:1];
    
}
- (IBAction)zhifubaoPay:(UIButton *)sender {
    
    [self makeSureToPay:2];
}

- (void)makeSureToPay:(int)payFlag {
    _moneyStr =@"0.01";
    if (payFlag ==2) {
        [NetUserService request_Api_User_Capital_create_recharge_order:_moneyStr success:^(id data) {
            _payOrderModel =data;
            [self Alipay:_payOrderModel];
        } error:^(NSString *errMsg) {
            [BaseInfo showErrorMessage:errMsg];
        }];
        
        
        
    } else if (payFlag  ==1) {
        
        NSURL * url = [NSURL URLWithString:@"weixin://"];
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
        //先判断是否能打开该url
        if (canOpen)
        {   //打开微信
            [NetUserService request_Api_User_Capital_create_recharge_order:_moneyStr type:@"wx" success:^(id data) {
                _payOrderModel =data;
                _payOrderModel.prepayId =@"wx20170710170645a49a1426310896879319";
                [self WeiXinpay:_payOrderModel];
            } error:^(NSString *errMsg) {
                [BaseInfo showErrorMessage:errMsg];
            }];
        }else {
            [BaseInfo showErrorMessage:@"您还未安装微信"];
        }
        
        
    }
    
    
    
}



#pragma mark - pay
- (void)Alipay:(NetPayOrderModel *)model
{
    self.aliPay.money = _moneyStr;
    self.aliPay.orderNum = model.order_no;
    self.aliPay.bodyContent = @"充值";
    self.aliPay.subjectContent = @"支付金额";
    self.aliPay.callBackString =URLString(@"/Api/Pay/Callback/ali_recharge_callback");
    [self.aliPay payZFBMethod];
    
}


- (void)WeiXinpay:(NetPayOrderModel *)model
{
    self.weixinPay.money =_moneyStr;
    self.weixinPay.orderNum = @"2017071051994954";
    self.weixinPay.bodyContent = @"会员升级";
    self.weixinPay.prepayId =@"wx20170710170645a49a1426310896879319";
    self.weixinPay.callBackString =URLString(@"/Api/Pay/Callback/weixin_recharge_callback");
    [self.weixinPay payWXMethod];
}


#pragma mark - setter & getter
//支付宝支付
- (BaijiAliPay *)aliPay
{
    if (!_aliPay) {
        _aliPay = [[BaijiAliPay alloc]init];
        __weak HomePageViewController *weakSelf = self;
        _aliPay.listenAliPaySuccess = ^{
            //            [weakSelf turnToSuccessPage];
            
        };
        _aliPay.listenAliPayFailure = ^{
            [BaseInfo showErrorMessage:@"支付失败"];
        };
    }
    return _aliPay;
}

- (BaijiWeixinPay *)weixinPay
{
    if (!_weixinPay) {
        _weixinPay = [[BaijiWeixinPay alloc]init];
        __weak HomePageViewController *weakSelf = self;
        _weixinPay.listenAliPaySuccess = ^{
            //            [weakSelf turnToSuccessPage];
            
        };
        _weixinPay.listenAliPaySuccess = ^{
            [BaseInfo showErrorMessage:@"支付成功"];
        };
    }
    return _weixinPay;
}

- (IBAction)identifyCardBtn:(UIButton *)sender {
    
    
}



- (IBAction)clickAction:(UIButton *)sender {
   
    [self pushAniMation:@"PublicAboutUsViewController" withPropertyDic:@{@"logStr":@"123"}];
    
//    
//    [AppDelegate sharingMethodCall:@"home_video" shareUrl:@"http://www.baidu.com" shareTitle:@"测试分享" shareContent:@"测试分享内容"];
   
//    [[JYRouter router] push:@"SimpleTwoViewController"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
