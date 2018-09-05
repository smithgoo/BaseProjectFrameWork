//
//  VideoListTableViewCell.h
//  VipVideoProject
//
//  Created by 王朋 on 2018/8/29.
//  Copyright © 2018 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListTableViewCell.h"
#import "VideoListViewController.h"
#import "CommFileHead.h"
@interface VideoListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movesNam;
@property (weak, nonatomic) IBOutlet UILabel *speedLab;
@property (weak, nonatomic) IBOutlet UILabel *presentLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (nonatomic,strong) downLoadModel *model;
// 下载任务句柄
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic,strong) NSTimer *timers;
@property (nonatomic,assign) NSInteger caculateCount;

@property (weak, nonatomic) IBOutlet UIButton *btn_down;
@property (nonatomic,assign) long long int frontData;
@property (nonatomic,assign) long long int afterData;
-(void)bingModel:(downLoadModel*)model;
@end
