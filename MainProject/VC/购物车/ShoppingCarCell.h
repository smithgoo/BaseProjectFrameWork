//
//  ShoppingCarCell.h
//  MainProject
//
//  Created by 王朋 on 2017/5/18.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarTotalModel.h"
@interface ShoppingCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *choiceFlagBtn;
@property (weak, nonatomic) IBOutlet UIImageView *projectImg;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *projectSubTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *projectMoney;

@property (nonatomic,copy) void(^choiceCountCallBack)(int counts);

-(void)binding:(ShopCarTotalModel*)model;
@end
