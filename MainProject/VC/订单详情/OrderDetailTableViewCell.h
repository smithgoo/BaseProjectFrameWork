//
//  OrderDetailTableViewCell.h
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *toEvaluateBtn;

@property (weak, nonatomic) IBOutlet UIButton *goToThePaymentBtn;

@property (nonatomic,strong)  UIViewController *superVC;
@end
