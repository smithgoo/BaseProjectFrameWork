//
//  TheShoppingCartViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/18.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "TheShoppingCartViewController.h"
#import "ShoppingCarCell.h"
#import "ShopCounterView.h"
#import "ShopCarTotalModel.h"
#import "ShoppingCarRecommendCell.h"
@interface TheShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *goToThePaymentBtn;
@property (weak, nonatomic) IBOutlet UITableView *contentTableview;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLab;
@property (nonatomic,strong) NSMutableArray *choicelistArr;
@property (nonatomic,assign) int totalPrice;
@property (nonatomic,assign) int projectCount;
@end

@implementation TheShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentTableview.delegate =self;
    _contentTableview.dataSource =self;
    _contentTableview.tableFooterView =[UIView new];
    // Do any additional setup after loading the view from its nib.
    _choicelistArr =[NSMutableArray array];
    
    ShopCarTotalModel *model1 =[ShopCarTotalModel new];
    model1.choiceCount =0;
    model1.perPrice =1200;
    
    ShopCarTotalModel *model2 =[ShopCarTotalModel new];
    model2.choiceCount =0;
    model2.perPrice =1200;
    
    ShopCarTotalModel *model3 =[ShopCarTotalModel new];
    model3.choiceCount =0;
    model3.perPrice =1200;
    
    [_choicelistArr addObjectsFromArray:@[model1,model2,model3]];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 90;
            break;
        case 1:
            return (km_screen_width/2+80)*3;
            break;
        default:
            break;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return 10;
    }
    return 30;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 
    return 0.01;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {
        ShoppingCarCell *cell =[ShoppingCarCell initWithOwner:self nibName:@"ShoppingCarCell" index:1];
        return cell;
    }
    return nil;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            ShoppingCarCell *cell =[ShoppingCarCell initWithOwner:self nibName:@"ShoppingCarCell" index:0];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            [cell binding:[_choicelistArr objectAtIndex:indexPath.row]];
           
            cell.choiceCountCallBack =^(int counts){
                ShopCarTotalModel *modelX =[_choicelistArr objectAtIndex:indexPath.row];
                modelX.choiceCount =counts;
               _totalPrice =0;
                _projectCount =0;
                [_choicelistArr enumerateObjectsUsingBlock:^(ShopCarTotalModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    _totalPrice = obj.choiceCount*obj.perPrice +_totalPrice;
                    _projectCount =obj.choiceCount+_projectCount;
                }];
                NSLog(@"%d",_totalPrice);
                _totalPriceLab.text =[NSString stringWithFormat:@"%d",_totalPrice];
                [_goToThePaymentBtn setTitle:[NSString stringWithFormat:@"去结算(%d)",_projectCount] forState:UIControlStateNormal];
            };
            
            return cell;
        }
            break;
            
        case 1:
        {
            ShoppingCarRecommendCell *cell =[ShoppingCarRecommendCell initWithOwner:self nibName:@"ShoppingCarRecommendCell" index:0];
            cell.superVC =self;
              cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
            
        }
            break;
            
            
        default:
            break;
    }
    
    return nil;

}


@end
