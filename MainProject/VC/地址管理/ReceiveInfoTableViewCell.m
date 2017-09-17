//
//  ReceiveInfoTableViewCell.m
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "ReceiveInfoTableViewCell.h"

@implementation ReceiveInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnChoice.layer.cornerRadius =3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
