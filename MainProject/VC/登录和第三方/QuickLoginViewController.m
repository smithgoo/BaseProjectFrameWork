//
//  QuickLoginViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/20.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "QuickLoginViewController.h"
#import "NormalLoginViewController.h"
#import "PublicAboutUsViewController.h"
#import "RegisteredToLoginViewController.h"
@interface QuickLoginViewController ()
@property (weak, nonatomic) IBOutlet JKCountDownButton *quickLogBtn;
@property (weak, nonatomic) IBOutlet UITextField *telphoneTex;
@property (weak, nonatomic) IBOutlet UITextField *passPortTex;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *weixinLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *weiboLoginBtn;
@property (weak, nonatomic) IBOutlet UIView *coverView; //是否隐藏 第三方登录按钮
@end

@implementation QuickLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BaseInfo setTextFieldInset:_telphoneTex left:10];
    [BaseInfo setTextFieldInset:_passPortTex left:10];
    // Do any additional setup after loading the view from its nib.
    _telphoneTex.layer.borderColor =km_rgb_hex(0xffffff).CGColor;
    //    _telphoneTex.layer.borderWidth=1;
    
    _passPortTex.layer.borderColor =km_rgb_hex(0xffffff).CGColor;
    //    _passPortTex.layer.borderWidth=1;
    
    [_telphoneTex setValue:km_rgb_hex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [_telphoneTex setValue:[UIFont boldSystemFontOfSize:15]forKeyPath:@"_placeholderLabel.font"];
    
    [_passPortTex setValue:km_rgb_hex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [_passPortTex setValue:[UIFont boldSystemFontOfSize:15]forKeyPath:@"_placeholderLabel.font"];
    
    _loginBtn.layer.cornerRadius=6;
    
    _weixinLoginBtn.layer.cornerRadius = _weixinLoginBtn.frame.size.width/2;
    _qqLoginBtn.layer.cornerRadius = _weixinLoginBtn.frame.size.width/2;
    _weiboLoginBtn.layer.cornerRadius = _weixinLoginBtn.frame.size.width/2;
    
    if (_isNeedThirdLogin) {
        _coverView.hidden =NO;
    } else {
        _coverView.hidden =YES;
    }
    
    
}


- (IBAction)clickAction:(JKCountDownButton *)sender {
    
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:50.0];
    
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"%ld秒",second];
        //网络请求 来请求验证码
        return title;
    }];
    
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
    }];
    
}
- (IBAction)loginAction:(UIButton *)sender {
    
    PublicAboutUsViewController *public =[PublicAboutUsViewController new];
    public.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:public animated:YES];
    
    
//    NormalLoginViewController *normal =[NormalLoginViewController new];
//    normal.hidesBottomBarWhenPushed =YES;
//    [self.navigationController pushViewController:normal animated:YES];
    
    
}

- (IBAction)registeredAction:(UIButton *)sender {
    RegisteredToLoginViewController *registered =[RegisteredToLoginViewController new];
    
    [self.navigationController pushViewController:registered animated:YES];
    
}






@end
