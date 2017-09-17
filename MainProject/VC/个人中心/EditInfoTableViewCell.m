//
//  EditInfoTableViewCell.m
//  MainProject
//
//  Created by 王朋 on 2017/5/16.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "EditInfoTableViewCell.h"
@interface EditInfoTableViewCell ()<UITextFieldDelegate>

@end;
@implementation EditInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _rightTef.delegate =self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (_tefTexCallBack) {
        _tefTexCallBack(textField.text);
    }

}

@end

@implementation EditInfoTableViewOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
