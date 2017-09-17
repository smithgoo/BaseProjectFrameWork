//
//  PublicAboutUsViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/15.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "PublicAboutUsViewController.h"
#import "AboutUsTableViewCell.h"
@interface PublicAboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UITableView *tableContent;
@property (weak, nonatomic) IBOutlet UILabel *labCopyright;
@property (weak, nonatomic) IBOutlet UILabel *labCompany;

@property (nonatomic,strong) NSString *versionStr;
@end

@implementation PublicAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    
    //获取版本号
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSString *version = [dict objectForKey:@"CFBundleShortVersionString"];
    _versionStr =[NSString stringWithFormat:@"V%@",version];
    NSLog(@"---%@",_logStr);
}

-(void)setupUI {

    _logoImg.layer.cornerRadius =50;
    _logoImg.layer.borderWidth=.5;
    _logoImg.layer.borderColor =km_rgb_hex(0xdfdfdf).CGColor;
    
    
    _tableContent.delegate =self;
    _tableContent.dataSource =self;
    _tableContent.scrollEnabled =NO;
    _tableContent.layer.borderWidth=.5;
    _tableContent.layer.borderColor =km_rgb_hex(0xdfdfdf).CGColor;
    
    
}
- (IBAction)backAction:(UIButton *)sender {
    [self popAnimation];
    
    return;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AboutUsTableViewCell *cell =[AboutUsTableViewCell initWithOwner:self nibName:@"AboutUsTableViewCell" index:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row ==2) {
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.labLeft.text =[@[@"版本号",@"联系电话",@"关于我们"] objectAtIndex:indexPath.row];
    
    cell.labRight.text =[@[_versionStr,@"40078611111",@""] objectAtIndex:indexPath.row];
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    

}





@end
