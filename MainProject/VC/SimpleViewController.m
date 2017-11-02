//
//  SimpleViewController.m
//  MainProject
//
//  Created by smithgoo on 2017/10/31.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate =self;
    _tableView.dataSource =self;

    _dataArr =@[@"网易严选竖着",@"网易严选横着",@"星星评分控件",@"点赞收藏控件",@"自定义键盘",@"判断点是否在某个区域内",@"上下翻转的banner广告含点击事件"];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"identify";

    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    if (!cell) {
        cell =[tableView dequeueReusableCellWithIdentifier:identify];
        
    }
    cell.textLabel.text =[_dataArr objectAtIndex:indexPath.row];
    return cell;
    
}


@end