//
//  OrderDetailViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"
#import "TheShoppingCartViewController.h"
@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentTableView.delegate =self;
    _contentTableView.dataSource =self;
    
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==3) {
        return 49;
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailTableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            cell =[OrderDetailTableViewCell initWithOwner:self nibName:@"OrderDetailTableViewCell" index:1  ];
        }
            break;
        case 1:
        {
            cell =[OrderDetailTableViewCell initWithOwner:self nibName:@"OrderDetailTableViewCell" index:0  ];
        }
            break;
        case 2:
        {
            cell =[OrderDetailTableViewCell initWithOwner:self nibName:@"OrderDetailTableViewCell" index:2];
        }
            break;
        case 3:
        {
            cell =[OrderDetailTableViewCell initWithOwner:self nibName:@"OrderDetailTableViewCell" index:3];
        }
            break;
            
        default:
            break;
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TheShoppingCartViewController *shopcar =[TheShoppingCartViewController new];
    [self.navigationController pushViewController:shopcar animated:YES];

}








@end
