//
//  SeetingViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/20.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "SeetingViewController.h"
#import "FirstTableViewCell.h"
@interface SeetingViewController ()<UITableViewDelegate,UITableViewDataSource> {
 CGFloat file;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArr;
@end

@implementation SeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr =@[@"修改密码",@"消息设置",@"省流量不看图片",@"清空缓存",@"分享XX",@"意见反馈",@"退出登录"];
    _tableView.tableFooterView =[UIView new];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleArr.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    static NSString *identify =@"identify";
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    if (!cell) {
        cell =[tableView dequeueReusableCellWithIdentifier:identify];
    }
    
    cell.textLabel.text =[_titleArr objectAtIndex:indexPath.row];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath.row==3) {
        
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%.2fM",[self folderSizeAtPath:cachPath]];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
        {
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
            //省流量
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            BOOL result = [userDefaults boolForKey:@"shengliuliang"];
        }
            break;
        case 3:
        {
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                    
                    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                    
                    //NSLog(@"files :%lu",(unsigned long)[files count]);
                    
                    for (NSString *p in files) {
                        
                        NSError *error;
                        NSString *path = [cachPath stringByAppendingPathComponent:p];
                        
                        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                            
                            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"清理成功" message:[NSString stringWithFormat:@"清理成功,清空了%.2fM空间",file] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alert show];
                        NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
                        
                        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
                    });
                });
            }
        }
            break;
        case 4:
        {
        }
            break;
        case 5:
        {
        }
            break;
        case 6:
        {
        }
            break;
            
        default:
            break;
    }

}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
