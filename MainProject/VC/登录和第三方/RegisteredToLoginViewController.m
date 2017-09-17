//
//  RegisteredToLoginViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/15.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "RegisteredToLoginViewController.h"
#import "QuickLoginViewController.h"
#import "PayForSuccessAndFailureViewController.h"
@interface RegisteredToLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tefTelphone;
@property (weak, nonatomic) IBOutlet UITextField *tefVerificationCode;
@property (weak, nonatomic) IBOutlet UITextField *tefPassword;
@property (weak, nonatomic) IBOutlet JKCountDownButton *btnVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *btnMakeSure;
@property (weak, nonatomic) IBOutlet UIButton *btnFlag;

@end

@implementation RegisteredToLoginViewController
- (IBAction)loginAction:(UIButton *)sender {
    QuickLoginViewController *quickLogin =[QuickLoginViewController new];
    [self.navigationController pushViewController:quickLogin animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    [BaseInfo setTextFieldInset:_tefTelphone left:10];
     [BaseInfo setTextFieldInset:_tefVerificationCode left:10];
     [BaseInfo setTextFieldInset:_tefPassword left:10];
    [_tefTelphone setValue:km_rgb_hex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [_tefTelphone setValue:[UIFont systemFontOfSize:14]forKeyPath:@"_placeholderLabel.font"];
    [_tefVerificationCode setValue:km_rgb_hex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [_tefVerificationCode setValue:[UIFont systemFontOfSize:14]forKeyPath:@"_placeholderLabel.font"];
    [_tefPassword setValue:km_rgb_hex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [_tefPassword setValue:[UIFont systemFontOfSize:14]forKeyPath:@"_placeholderLabel.font"];
    _tefPassword.secureTextEntry =YES;
    
    _btnVerificationCode.layer.cornerRadius=6;
    _btnMakeSure.layer.cornerRadius =6;
    

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
        return @"获取验证码";
    }];
    
}

- (IBAction)makesureAction:(UIButton *)sender {
    
    PayForSuccessAndFailureViewController *pay =[PayForSuccessAndFailureViewController new];
    [self.navigationController pushViewController:pay animated:YES];
}

- (IBAction)thePasswordIsVisible:(UIButton *)sender {
    
    sender.selected =!sender.selected;
    if (sender.selected) {
        _tefPassword.secureTextEntry =NO;
        [_btnFlag setImage:[UIImage imageNamed:@"login_hiddenPasswrod"] forState:UIControlStateNormal];
        
    } else {
        [_btnFlag setImage:[UIImage imageNamed:@"login_showPassword"] forState:UIControlStateNormal];
        _tefPassword.secureTextEntry =YES;
    }
    
}


@end
