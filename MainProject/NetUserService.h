//
//  NetUserService.h
//  MainProject
//
//  Created by cnsunrun on 2017/4/28.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "NetBaseService.h"
#import "URLDefine.h"
@interface NetTiXianModelService : NSObject

@property (nonatomic,strong) NSString* user_key;

@property (nonatomic,strong) NSString* price;

@property (nonatomic,strong) NSString* type;

@property (nonatomic,strong) NSString* ali_account;

@property (nonatomic,strong) NSString* wx_open_id;

@property (nonatomic,strong) NSString* pay_password;
@end

@class NetTiXianModelService;
@interface NetUserService : NetBaseService

//入参
@property (nonatomic,strong) NSString* user_key;


//出参
@property (nonatomic,strong) NSString* age;
@property (nonatomic,strong) NSString* constellation;
@property (nonatomic,strong) NSString* gender;
@property (nonatomic,strong) NSString* gender_text;
@property (nonatomic,strong) NSString* head_img;
@property (nonatomic,strong) NSString* hobbies;
@property (nonatomic,strong) NSString* integral;
@property (nonatomic,strong) NSString* mobile;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,strong) NSString* signature;
@property (nonatomic,strong) NSString* skill;
@property (nonatomic,strong) NSString* start_rating;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* title_id;
@property (nonatomic,strong) NSString* uid;


//读取相片的扩展字段
@property (nonatomic,strong) NSString* id;
@property (nonatomic,strong) NSString* image;
@property (nonatomic,strong) NSString* addtime;
@property (nonatomic,strong) NSString* add_time;

//"id": "4",  //图片ID
//"image": "http://localhost/sc/Uploads/photo/1/20170610/593b822e67e0f.jpeg",  //图片路径
//"addtime": "1497072174",  //更新时间
//"add_time": "2017-06-10 13:22" //更新时间


//{
//    "status": "1",
//    "msg": "ok",
//    "info": {
//        "mobile": "18062878866",   //手机号
//        "uid": "1",   //用户ID
//        "nickname": "就是这么快的后端",  //昵称
//        "head_img": "http://localhost/sc/Uploads/Headimg/20170610/593b877908c7f.jpeg",  //头像
//        "signature": "这么长的个性签名，你怕不怕?",  //签名
//        "gender": "2",  //性别
//        "age": "7",     //年龄
//        "integral": "0",   //积分
//        "skill": "这么少的技能点，你怕不怕?",  //技能
//        "hobbies": "爱好是什么能吃吗？",   //爱好
//        "title_id": "2",   //头衔ID
//        "gender_text": "女", //性别
//        "title": "初出茅庐"  //头衔
//    }
//}

//个人中心请求数据
+ (void)request_Api_User_Index_get_user_info:(NetUserService*)model   success:(ResponseResult)succ error:(ResponseResultErr)err;
//个人中心上传图片
+ (void)request_Api_User_Edit_edit_headimg:(NSData*)headimg success:(ResponseSuc)succ error:(ResponseErr)err;

//个人中心昵称
+ (void)request_Api_User_Edit_edit_nickname:(NSString*)nick_name success:(ResponseSuc)succ error:(ResponseErr)err;


//个性签名
+ (void)request_Api_User_Edit_edit_signature:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err;

//技能
+ (void)request_Api_User_Edit_edit_skill:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err;

//爱好
+ (void)request_Api_User_Edit_edit_hobbies:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err;



//年龄
+ (void)request_Api_User_Edit_edit_age:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err;

//性别
+ (void)request_Api_User_Edit_edit_gender:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err;

// 换绑手机号 验证码
+ (void)request_Api_User_Edit_send_bind_mobile_code:(NSString*)mobile success:(ResponseSuc)succ error:(ResponseErr)err;

//验证旧手机号
+ (void)request_Api_User_Edit_bind_phone_by_code_two:(NSString*)code success:(ResponseSuc)succ error:(ResponseErr)err;

//绑定手机号
+ (void)request_Api_User_Edit_bind_phone:(NSString*)mobile code:(NSString*)code success:(ResponseSuc)succ error:(ResponseErr)err;

// 我的相册
+ (void)request_Api_User_Index_get_user_photosuccess:(ResponseResult)succ error:(ResponseResultErr)err;

//添加相片
+ (void)request_Api_User_Edit_add_photo:(NSDictionary*)headimg success:(ResponseSuc)succ error:(ResponseErr)err ;

//删除照片
+ (void)request_Api_User_Edit_del_photo:(NSString*)imgId success:(ResponseSuc)succ error:(ResponseErr)err ;


//充值请求订单号
+ (void)request_Api_User_Capital_create_recharge_order:(NSString*)money success:(ResponseSuc)succ error:(ResponseErr)err ;

//充值请求订单号
+ (void)request_Api_User_Capital_create_recharge_order:(NSString*)money type:(NSString*)type success:(ResponseSuc)succ error:(ResponseErr)err;

//获取支付页面手机号
+ (void)request_Api_User_Edit_edit_pay_password_oneSuccess:(ResponseSuc)succ error:(ResponseErr)err ;


//修改支付密码 发送验证码

+ (void)request_Api_User_Edit_edit_pay_password_by_send_codeSuccess:(ResponseSuc)succ error:(ResponseErr)err ;


//修改支付密码-验证手机号

+ (void)request_Api_User_Edit_edit_pay_password_by_check_code:(NSString*)code Success:(ResponseSuc)succ error:(ResponseErr)err;

//修改支付密码
+ (void)request_Api_User_Edit_edit_pay_password:(NSString*)oldPsd newPsd:(NSString*)newPsd Success:(ResponseSuc)succ error:(ResponseErr)err;

//获取我的提现余额
+ (void)request_Api_User_Index_get_user_balanceSuccess:(ResponseSuc)succ error:(ResponseErr)err;
//提现剩余次数
+ (void)request_Api_User_Capital_get_withdraw_infoSuccess:(ResponseSuc)succ error:(ResponseErr)err;
//联系客服
+ (void)request_Api_Common_Index_kfSuccess:(ResponseSuc)succ error:(ResponseErr)err;

//余额提现
+ (void)request_Api_User_Capital_withdraw:(NetTiXianModelService*)model Success:(ResponseSuc)succ error:(ResponseErr)err;


// 获取我的推广码
+ (void)request_Api_User_Index_get_user_recommend_numSuccess:(ResponseSuc)succ error:(ResponseErr)err;

//填写我的推广人
+ (void)request_Api_User_Edit_set_user_recommend:(NSString*)recommend_code Success:(ResponseSuc)succ error:(ResponseErr)err;

// 关联手机号
+ (void)request_Api_User_Edit_extends_login_bind_phone:(NSString*)mobile code:(NSString*)code Success:(ResponseSuc)succ error:(ResponseErr)err;
@end

 
