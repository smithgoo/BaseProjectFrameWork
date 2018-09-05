//
//  VideoListTableViewCell.m
//  VipVideoProject
//
//  Created by 王朋 on 2018/8/29.
//  Copyright © 2018 王朋. All rights reserved.
//

#import "VideoListTableViewCell.h"
#import "VideoListViewController.h"
@implementation VideoListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _caculateCount =0;
    _frontData =0;
    _afterData =0;
}
-(void)bingModel:(downLoadModel*)model {
    _model =model;
    _movesNam.text =model.movesName;
    if (model.completeStatues == 0) {
        _btn_down.selected = NO;
    }else{
        _btn_down.selected = YES;
        _statusLab.text =model.completeStatues ==2 ?@"已完成":@"进行中";
    }
 
    [self updataUI];
    __weak typeof(self) weakSelf = self;
    _model.UpdataUiBlock = ^{
        [weakSelf updataUI];
    };
    _model.DownFinshBlock = ^{
        [weakSelf downLoadFinsh];
    };
}
- (void)updataUI
{
    _presentLab.text = _model.persent;
    _speedLab.text = _model.speed;
    _statusLab.textColor = [UIColor blackColor];
    switch (_model.completeStatues) {
        case 0:
        {
            _statusLab.text = @"未下载";
            
        }
            break;
        case 1:
        {
            _statusLab.text = @"下载中";
            _statusLab.textColor = [UIColor redColor];
            
            
        }
            break;
        case 2:
        {
            _statusLab.text = @"下载完成";
            _statusLab.textColor = [UIColor greenColor];
            
            
        }
            break;
            
        default:
            break;
    }
    if (_model.completeStatues == 0) {
        _statusLab.text = @"未下载";
    }
}
- (void)downLoadFinsh
{
    _statusLab.text = @"下载完成";
    [self updataUI];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startDownload:(UIButton *)sender {
//单个断点续传的使用
    sender.selected =!sender.selected;
    
    [_model downLoadMoveWithIsSelect:sender.selected];
}




@end
