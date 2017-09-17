//
//  NormalLoginViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/20.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "NormalLoginViewController.h"

@interface NormalLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTex;
@property (weak, nonatomic) IBOutlet UITextField *passWordTex;

@end

@implementation NormalLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BaseInfo setTextFieldInset:_usernameTex left:60];
    [BaseInfo setTextFieldInset:_passWordTex left:60];
    _passWordTex.secureTextEntry =YES;
    _passWordTex.clearButtonMode =UITextFieldViewModeAlways;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//找回密码

- (IBAction)findBackPassWorld:(UIButton *)sender {
    
    
}

//注册帐号

- (IBAction)registered:(UIButton *)sender {
    
}



@end
