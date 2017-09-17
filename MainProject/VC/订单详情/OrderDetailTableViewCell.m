//
//  OrderDetailTableViewCell.m
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _toEvaluateBtn.layer.cornerRadius=3;
    _toEvaluateBtn.layer.borderColor =km_rgb_hex(0xcccccc).CGColor;
    _toEvaluateBtn.layer.borderWidth =1;
    
    _goToThePaymentBtn.layer.cornerRadius=3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
