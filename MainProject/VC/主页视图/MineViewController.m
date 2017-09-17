//
//  MineViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/20.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    JKCountDownButton *button = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
    [button countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        
        [sender startCountDownWithSecond:10.0];
        
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%ld秒",second];
            return title;
        }];
        
 
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
        }];
      
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
