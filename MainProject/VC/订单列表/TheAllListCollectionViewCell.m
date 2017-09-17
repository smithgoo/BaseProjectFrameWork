//
//  TheAllListCollectionViewCell.m
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "TheAllListCollectionViewCell.h"
#import "TheAllListTableViewCell.h"
#import "OrderDetailViewController.h"
@interface TheAllListCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation TheAllListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _contentTableView.delegate =self;
    _contentTableView.dataSource =self;
    // Initialization code
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 48;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 TheAllListTableViewCell *cell =[TheAllListTableViewCell initWithOwner:self nibName:@"TheAllListTableViewCell" index:1];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TheAllListTableViewCell *cell =[TheAllListTableViewCell initWithOwner:self nibName:@"TheAllListTableViewCell" index:2];
    return cell;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TheAllListTableViewCell *cell =[TheAllListTableViewCell initWithOwner:self nibName:@"TheAllListTableViewCell" index:0];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *order =[OrderDetailViewController new];
    [self.superVC.navigationController pushViewController:order animated:YES];
    
    NSLog(@"%@---indexpath",indexPath);
};

@end
