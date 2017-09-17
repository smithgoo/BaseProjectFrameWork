//
//  ShoppingCarCell.m
//  MainProject
//
//  Created by 王朋 on 2017/5/18.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "ShopCounterView.h"
@interface ShoppingCarCell()
@property (nonatomic,strong) ShopCounterView *countView;
@end
@implementation ShoppingCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _countView =[ShopCounterView new];
    _countView.backgroundColor =[UIColor whiteColor];
    [self addSubview:_countView];
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    __block typeof(self) wkself =self;
    _countView.choiceCountCallBack = ^(int counts) {
        if (wkself.choiceCountCallBack) {
            wkself.choiceCountCallBack(counts);
        }

    };
   
}

-(void)binding:(ShopCarTotalModel*)model {
    _projectMoney.text =[NSString stringWithFormat:@"%d",model.perPrice];
    _countView.showLab.text =[NSString stringWithFormat:@"%d",model.choiceCount];
    
}
@end
