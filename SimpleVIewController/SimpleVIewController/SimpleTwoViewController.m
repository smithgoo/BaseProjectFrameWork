//
//  SimpleTwoViewController.m
//  SimpleVIewController
//
//  Created by 王朋 on 2017/5/9.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "SimpleTwoViewController.h"
#import <JYRouter.h>
@interface SimpleTwoViewController ()

@end

@implementation SimpleTwoViewController


 


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor redColor];
    self.navigationItem.title =@"1234";
    

    
    
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"跳转到指定的地方" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushtovc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)pushtovc:(UIButton*)sender {
    
    //    self.navigationController.tabBarController.tabBar.hidden =YES;
    //    self.navigationController.navigationBar.hidden =NO;
    [[JYRouter router] push:@"CircleOfFriendsViewController"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
