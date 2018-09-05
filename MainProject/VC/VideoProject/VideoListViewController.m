//
//  VideoListViewController.m
//  VipVideoProject
//
//  Created by 王朋 on 2018/8/29.
//  Copyright © 2018 王朋. All rights reserved.
//

#import "VideoListViewController.h"
#import "CommFileHead.h"
#import "VideoListTableViewCell.h"

@implementation downLoadModel
- (void)downLoadMoveWithIsSelect:(BOOL)isSelect
{
    if (!_downloadTask) {
        self.completeStatues =1;
        [self downFileFromServer:self.downLoadUrl];
    }
    if (isSelect) {
        //恢复
        [_downloadTask resume];
    }  else {
        
        //暂停
        [_downloadTask suspend];
    }
}

//递归文件下载
- (void)downFileFromServer:(NSString *)urlStr {
    __weak typeof(self) weakSelf = self;
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //下载Task操作
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        weakSelf.afterData =downloadProgress.completedUnitCount;
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            weakSelf.persent = [NSString stringWithFormat:@"%1.f%@",downloadProgress.fractionCompleted*100,@" %"];
//            self.presentLab.text =[NSString stringWithFormat:@"%1.f%@",downloadProgress.fractionCompleted*100,@" %"];
//            weakSelf.model.persent =self.presentLab.text;
            if (!weakSelf.timers) {
                weakSelf.timers =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(caculateProjectSpeeds) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:weakSelf.timers forMode:NSRunLoopCommonModes];
            }
            if (downloadProgress.fractionCompleted>=1) {
                [weakSelf.timers invalidate];
                weakSelf.timers =nil;
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        // 要求返回一个URL, 这个URL就是文件的位置的路径
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        
        NSLog(@"文件路径：%@",path);
        //        self.path = path;
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
//        self.statusLab.text =@"下载完成";
        weakSelf.iscomplete =YES;
        weakSelf.speed =@"0kb/s";
        weakSelf.persent =@"100%";
        
        if (self.DownFinshBlock) {
            self.DownFinshBlock();
        }
        
    }];
}
- (void)caculateProjectSpeeds {
    
    float speeds = (_afterData-_frontData)/1024;
    
    if (speeds>=512) {
        self.speed  =[NSString stringWithFormat:@"%1.fM/s",speeds/1024.0];
//        _model.speed =_speedLab.text;
    } else {
        self.speed =[NSString stringWithFormat:@"%1.fkb/s",speeds];
//        _model.speed =_speedLab.text;
    }
    NSLog(@"%ld---%1.fkb/s",_caculateCount++,speeds);
    _frontData =_afterData;
    
    if (self.UpdataUiBlock) {
        self.UpdataUiBlock();
    }
    
}


@end

@interface VideoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    // Do any additional setup after loading the view from its nib.
    _tableView.tableFooterView =[UIView new];
    _dataArr =[NSMutableArray array];
    
    
    for (int i = 0; i < 20; i++) {
        downLoadModel *model0 =[downLoadModel new];
        model0.movesName =@"白夜追凶";
        model0.speed =@"0kb/s";
        model0.persent =@"0%";
        model0.downLoadUrl =@"https://cdn.llscdn.com/yy/files/xs8qmxn8-lls-LLS-5.8-800-20171207-111607.apk";
        model0.iscomplete =NO;
        [_dataArr addObject:model0];
    }
    
    
  
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    VideoListTableViewCell *cell =[VideoListTableViewCell initWithOwner:self nibName:@"VideoListTableViewCell" index:0];
    [cell bingModel:[_dataArr objectAtIndex:indexPath.row]];
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
