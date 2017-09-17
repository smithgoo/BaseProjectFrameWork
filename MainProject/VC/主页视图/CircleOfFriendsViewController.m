//
//  CircleOfFriendsViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/20.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "CircleOfFriendsViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "AppDelegate+MobShare.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
 #import <ShareSDK/SSDKTypeDefine.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

#import <CardIO.h>
#import <MMPlaceHolder.h>
@interface CircleOfFriendsViewController ()<CardIOViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *simpleBtn;
@property (weak, nonatomic) IBOutlet UILabel *simpleLab;

@end

@implementation CircleOfFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![CardIOUtilities canReadCardWithCamera]) {
        NSLog(@"请开启摄像头");
    } else {
        [CardIOUtilities preload];
    }
    // Do any additional setup after loading the view from its nib.
    _simpleBtn.showPlaceHolder;
    _simpleLab.showPlaceHolder ;
}

// 第三方登录的方法
- (void)loginBtnClickHandler:(id)sender
{
    NSLog(@"123");
//    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
//                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
//                                       
//                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
//                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
//                                       associateHandler (user.uid, user, user);
//                                       NSLog(@"dd%@",user.rawData);
//                                       NSLog(@"dd%@",user.credential);
//                                       
//                                   }
//                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
//                                    
//                                    if (state == SSDKResponseStateSuccess)
//                                    {
//                                        
//                                    }
//                                    
//                                }];
//    
    //例如QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
