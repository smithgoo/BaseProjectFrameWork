//
//  ReceivingInformationViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "ReceivingInformationViewController.h"
#import "ReceiveInfoTableViewCell.h"
#import "TheAllListOfViewController.h"
@interface ReceivingInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *contentTableview;

@end

@implementation ReceivingInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentTableview.delegate =self;
    _contentTableview.dataSource =self;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 116;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReceiveInfoTableViewCell *cell =[ReceiveInfoTableViewCell initWithOwner:self nibName:@"ReceiveInfoTableViewCell" index:0    ];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        cell.viewFlag.backgroundColor =km_rgb_hex(0xDE031F);
    } else {
            cell.viewFlag.backgroundColor =[UIColor whiteColor];
            
        }
    return cell;
    
}


/**
 添加地址操作

 @param sender <#sender description#>
 */
- (IBAction)addInfoAction:(UIButton *)sender {
    
    TheAllListOfViewController *all =[TheAllListOfViewController new];
    
    [self.navigationController pushViewController:all animated:YES];
}




@end
