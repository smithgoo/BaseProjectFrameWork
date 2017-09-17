//
//  ReceiveInfoTableViewCell.h
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UIImageView *imgTel;
@property (weak, nonatomic) IBOutlet UIImageView *imgWhere;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore;
@property (weak, nonatomic) IBOutlet UILabel *btnChoiceDefault;
@property (weak, nonatomic) IBOutlet UIButton *btnChoice;
@property (weak, nonatomic) IBOutlet UIView *viewFlag;

@end
