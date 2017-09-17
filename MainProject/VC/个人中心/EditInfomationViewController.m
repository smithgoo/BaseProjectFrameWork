//
//  EditInfomationViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/16.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "EditInfomationViewController.h"
#import "EditInfoTableViewCell.h"
#import "EditInfoModel.h"
#import "ReceivingInformationViewController.h"
@interface EditInfomationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableviewContent;

@property (strong,nonatomic) NSArray *titleArr;

@property (nonatomic,strong) EditInfoModel *dataModel;
@end

@implementation EditInfomationViewController
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableviewContent.delegate =self;
    _tableviewContent.dataSource =self;
    _tableviewContent.tableFooterView =[UIView new];
    _tableviewContent.backgroundColor =[UIColor clearColor];
    [_tableviewContent setSeparatorColor:[UIColor clearColor]];
   
    [self initData];
}

- (void)initData {
    _titleArr =@[@"我的姓名",@"联系电话",@"所在区域",@"详细地址"];
    _dataModel =[EditInfoModel new];
    _dataModel.userName =@"";
    _dataModel.contentTel =@"";
    _dataModel.theArea =@"";
    _dataModel.areaDetail =@"";
}
- (IBAction)saveAction:(UIButton *)sender {
    [self.view endEditing:YES];
   
    NSLog(@"%@%@%@",_dataModel.userName,_dataModel.contentTel,_dataModel.areaDetail);
    if (_dataModel.userName.length<=0) {
        [BaseInfo showErrorMessage:@"请输入姓名"];
        return;
    }
    if (_dataModel.contentTel.length<=0) {
         [BaseInfo showErrorMessage:@"请输入联系电话"];
        return;
    }
    if ([_dataModel.theArea isEqualToString:@""]) {
         [BaseInfo showErrorMessage:@"请选择区域"];
        return;
    }
    if (_dataModel.areaDetail.length<=0) {
           [BaseInfo showErrorMessage:@"请输入详细地址"];
        return;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
            return 10;
            break;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 4;
            break;
            
        default:
            return 1;
            break;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EditInfoTableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:{
                    cell =[EditInfoTableViewCell initWithOwner:self nibName:@"EditInfoTableViewCell" index:0];
                    if (_dataModel.userName.length>0) {
                       cell.rightTef.text =_dataModel.userName;
                    } else {
                     cell.rightTef.placeholder =@"请输入姓名";
                    }
                    cell.tefTexCallBack =^(NSString *msg){
                        _dataModel.userName =msg;
                    };
                    cell.upLine.backgroundColor =km_rgb_hex(0xdfdfdf);
                }
                    break;
                case 1:{
                    cell =[EditInfoTableViewCell initWithOwner:self nibName:@"EditInfoTableViewCell" index:0];
                    cell.rightTef.placeholder =@"请输入联系电话";
                    if (_dataModel.contentTel.length>0) {
                        cell.rightTef.text =_dataModel.contentTel;
                    } else {
                       cell.rightTef.placeholder =@"请输入联系电话";
                    }
                    cell.rightTef.keyboardType =UIKeyboardTypeNumberPad;
                    cell.rightTef.text =_dataModel.contentTel;
                    cell.tefTexCallBack =^(NSString *msg){
                        _dataModel.contentTel =msg;
                    };
                     cell.upLine.backgroundColor =km_rgb_hex(0xf2f2f2);
                    [cell.upLine mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(cell.mas_left).offset(10);
                    }];
                     cell.downLine.backgroundColor =km_rgb_hex(0xf2f2f2);
                    [cell.downLine mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(cell.mas_left).offset(10);
                    }];
                }
                    break;
                case 2:{
                    cell =[EditInfoTableViewCell initWithOwner:self nibName:@"EditInfoTableViewCell" index:1];
                     cell.downLine.backgroundColor =km_rgb_hex(0xf2f2f2);
                    [cell.downLine mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(cell.mas_left).offset(10);
                    }];
                }
                    break;
                case 3:{
                    cell =[EditInfoTableViewCell initWithOwner:self nibName:@"EditInfoTableViewCell" index:0];
                    if (_dataModel.areaDetail.length>0) {
                        cell.rightTef.text =_dataModel.areaDetail;
                    } else {
                        cell.rightTef.placeholder =@"请输入详细地址";
                    }
                    cell.rightTef.text =_dataModel.areaDetail;
                    cell.tefTexCallBack =^(NSString *msg){
                        _dataModel.areaDetail =msg;
                    };
                     cell.downLine.backgroundColor =km_rgb_hex(0xdfdfdf);
                }
                    break;
                    
                default:
                    break;
            }
            cell.leftLab.text =[_titleArr objectAtIndex:indexPath.row];
        }
            break;
            
        case 1:{
          cell =[EditInfoTableViewCell initWithOwner:self nibName:@"EditInfoTableViewCell" index:2];
        
        }
            break;
            
        default:
            break;
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==2) {
                NSLog(@"点击了位置选择");
            }
        }
            break;
        case 1:
        {
//            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"" message:@"确定删除" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alert show];
            ReceivingInformationViewController *recevice =[ReceivingInformationViewController new];
            recevice.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:recevice animated:YES];
            
        }
            break;
            
        default:
            break;
    }

}

@end
