//
//  MineViewCell.m
//  MainProject
//
//  Created by 王朋 on 2018/9/3.
//  Copyright © 2018 王朋. All rights reserved.
//

#import "MineViewCell.h"

@implementation MineViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



@implementation MineHeadViewl

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
