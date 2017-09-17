//
//  PersonalCenterViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/15.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "EditInfomationViewController.h"
@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *labCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UITableView *tebleviewContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgVip;
@property (weak, nonatomic) IBOutlet UIImageView *imgWhere;

@end

@implementation PersonalCenterViewController


-(IBAction)pushToDetail:(id)sender {
    EditInfomationViewController *edit =[EditInfomationViewController new];
    [self.navigationController pushViewController:edit animated:YES];
     
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgLogo.layer.cornerRadius =32;
    _imgLogo.layer.borderColor =[UIColor whiteColor].CGColor;
    _imgLogo.layer.borderWidth =2;
    _tebleviewContent.delegate =self;
    _tebleviewContent.dataSource =self;
    _imgVip.backgroundColor =[UIColor whiteColor];
    _imgWhere.backgroundColor =[UIColor whiteColor];
    
    _tebleviewContent.tableFooterView =[UIView new];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)settingAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identify =@"identify";
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    if (!cell) {
        cell =[tableView dequeueReusableCellWithIdentifier:identify];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text =[NSString stringWithFormat:@"临时文案第一行%ld",indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.imageView.image =[UIImage imageNamed:@"aboutUs_logo"];
   
    
    return cell;
}
 

@end
