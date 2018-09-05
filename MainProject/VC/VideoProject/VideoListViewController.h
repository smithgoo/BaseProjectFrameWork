//
//  VideoListViewController.h
//  VipVideoProject
//
//  Created by 王朋 on 2018/8/29.
//  Copyright © 2018 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface downLoadModel : NSObject
@property (nonatomic,strong) NSString *movesName;
@property (nonatomic,strong) NSString *speed;
@property (nonatomic,strong) NSString *persent;
@property (nonatomic,strong) NSString *downLoadUrl;
@property (nonatomic,assign) BOOL iscomplete;

/**
 0 未开始  1下载中  2已完成
 */
@property (nonatomic,assign) int completeStatues;


@property(nonatomic,copy)void(^UpdataUiBlock)(void);


@property(nonatomic,copy)void(^DownFinshBlock)(void);


// 下载任务句柄
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic,strong) NSTimer *timers;
@property (nonatomic,assign) NSInteger caculateCount;

@property (nonatomic,assign) long long int frontData;
@property (nonatomic,assign) long long int afterData;


/**
 点击下载按钮
 */
- (void)downLoadMoveWithIsSelect:(BOOL)isSelect;

//递归文件下载
- (void)downFileFromServer:(NSString *)urlStr ;

@end


@interface VideoListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
