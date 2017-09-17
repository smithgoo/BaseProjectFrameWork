//
//  ViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/19.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "ViewController.h"
#import <RequestLibApi.h>
#import <ConfigInfo.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [RequestLibApi testAvailable];
    [ConfigInfo appUserId:@"123"];
    NSLog(@"%@",[ConfigInfo appUserId]);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
