//
//  PayForSuccessAndFailureViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/15.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "PayForSuccessAndFailureViewController.h"
#import "PersonalCenterViewController.h"
@interface PayForSuccessAndFailureViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageSuccessOrnot;
@property (weak, nonatomic) IBOutlet UILabel *labSuccessFlag;
@property (weak, nonatomic) IBOutlet UILabel *labPayHowMuch;
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UIButton *btnOrderDetail;

@end

@implementation PayForSuccessAndFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btnOrderDetail showPlaceHolder];
 
    [self setupUI];
}
- (IBAction)getOrderDetail:(UIButton *)sender {
    
    PersonalCenterViewController *personal =[PersonalCenterViewController new];
    [self.navigationController pushViewController:personal animated:YES];
}


- (void)setupUI{
    _viewBg.layer.cornerRadius =8;
   [_imageSuccessOrnot showPlaceHolder];
    
    _btnOrderDetail.layer.cornerRadius=3;

}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
