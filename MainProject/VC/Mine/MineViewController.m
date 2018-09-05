//
//  MineViewController.m
//  VipVideoProject
//
//  Created by 王朋 on 2018/8/30.
//  Copyright © 2018 王朋. All rights reserved.
//

#import "MineViewController.h"
#import "MineViewCell.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *leftTitleArr;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.tableFooterView =[UIView new];
    _leftTitleArr =@[@[@"开通VIP",@"观看记录",@"购买记录",@"我的下载"],@[@"邀请好友",@"修改密码",@"登出",@"版本1.1.1"]];
    
    MineHeadViewl *head =[MineViewCell initWithOwner:self nibName:@"MineViewCell" index:1];
    head.frame =CGRectMake(0, 0, km_screen_width, 200);
    _tableView.tableHeaderView =head;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _leftTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_leftTitleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineViewCell *cell =[MineViewCell initWithOwner:self nibName:@"MineViewCell" index:0];
    cell.leftTitle.text =[[_leftTitleArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
