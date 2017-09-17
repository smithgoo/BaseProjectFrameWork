//
//  NetUserService.m
//  MainProject
//
//  Created by cnsunrun on 2017/4/28.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "NetUserService.h"
#import "URLDefine.h"
#import "NetPayOrderModel.h"
#import "URLDefine.h"
@implementation NetTiXianModelService

@end

@implementation NetUserService
+ (void)request_Api_User_Index_get_user_info:(NetUserService*)model   success:(ResponseResult)succ error:(ResponseResultErr)err {
    NSString *url = Api_User_Index_get_user_info;
    [self get:url parameters:[model mj_keyValues] success:^(int code, NSString *msg, id data) {
        
        NetUserService *model1 =[NetUserService mj_objectWithKeyValues:data];
        
        succ(code,msg,model1);
    } error:^(int code, NSString *msg) {
        err(code,msg);
    } failure:^(NSError *failure) {
        
    }];
}

//个人中心上传图片
+ (void)request_Api_User_Edit_edit_headimg:(NSData*)headimg success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_headimg;
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    NSMutableDictionary *imgDic =[NSMutableDictionary dictionaryWithDictionary:@{@"headimg":headimg}];
    [self post:url parameters:dic datas:imgDic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//个人中心昵称
+ (void)request_Api_User_Edit_edit_nickname:(NSString*)nick_name success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_nickname;
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"nick_name":nick_name}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
    
}

//个性签名
+ (void)request_Api_User_Edit_edit_signature:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_signature;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"signature":signature}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}


//技能
+ (void)request_Api_User_Edit_edit_skill:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_skill;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"skill":signature}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//爱好
+ (void)request_Api_User_Edit_edit_hobbies:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err{
    
    NSString *url = Api_User_Edit_edit_hobbies;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"hobbies":signature}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//爱好
+ (void)request_Api_User_Edit_edit_age:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_age;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"age":signature}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//性别
+ (void)request_Api_User_Edit_edit_gender:(NSString*)signature success:(ResponseSuc)succ error:(ResponseErr)err {
    
    NSString *url = Api_User_Edit_edit_gender;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"gender":signature}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

// 换绑手机号 验证码
+ (void)request_Api_User_Edit_send_bind_mobile_code:(NSString*)mobile success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_send_bind_mobile_code;
    NSMutableDictionary *dic;
    if (mobile) {
        dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"mobile":mobile}];
    }else{
        
        dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    }
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
    
}

//验证旧手机号
+ (void)request_Api_User_Edit_bind_phone_by_code_two:(NSString*)code success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_bind_phone_by_code_two;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"code":code}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//绑定手机号
+ (void)request_Api_User_Edit_bind_phone:(NSString*)mobile code:(NSString*)code success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_bind_phone;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"code":code,@"mobile":mobile}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}


// 我的相册
+ (void)request_Api_User_Index_get_user_photosuccess:(ResponseResult)succ error:(ResponseResultErr)err {
    NSString *url = Api_User_Index_get_user_photo;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    [self get:url parameters:dic success:^(int code, NSString *msg, id data) {
        NSArray<NetUserService*>*modelArr =[NetUserService mj_objectArrayWithKeyValuesArray:data[@"photo_list"]];
        succ(code,msg,modelArr);
    } error:^(int code, NSString *msg) {
        err(code,msg);
    } failure:^(NSError *failure) {
        
    }];
}

//添加相片
+ (void)request_Api_User_Edit_add_photo:(NSDictionary*)headimg success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_add_photo;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    NSMutableDictionary *imgDic =[NSMutableDictionary dictionaryWithDictionary:headimg];
    [self post:url parameters:dic datas:imgDic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}


//删除照片
+ (void)request_Api_User_Edit_del_photo:(NSString*)imgId success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_del_photo;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"ids":imgId}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
     
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
  
}


//充值请求订单号
+ (void)request_Api_User_Capital_create_recharge_order:(NSString*)money success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Capital_create_recharge_order;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"money":money}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        NetPayOrderModel *model =[NetPayOrderModel mj_objectWithKeyValues:data];
        succ(model);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//充值请求订单号
+ (void)request_Api_User_Capital_create_recharge_order:(NSString*)money type:(NSString*)type success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Capital_create_recharge_order;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"money":money,@"type":type}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        NetPayOrderModel *model =[NetPayOrderModel mj_objectWithKeyValues:data];
        succ(model);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//获取支付页面手机号
+ (void)request_Api_User_Edit_edit_pay_password_oneSuccess:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_pay_password_one;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        
        succ(data[@"mobile"]);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//修改支付密码 发送验证码

+ (void)request_Api_User_Edit_edit_pay_password_by_send_codeSuccess:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_pay_password_by_send_code;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}


//修改支付密码-验证手机号

+ (void)request_Api_User_Edit_edit_pay_password_by_check_code:(NSString*)code Success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Edit_edit_pay_password_by_check_code;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"code":code}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];

}


//修改支付密码
+ (void)request_Api_User_Edit_edit_pay_password:(NSString*)oldPsd newPsd:(NSString*)newPsd Success:(ResponseSuc)succ error:(ResponseErr)err {

    NSString *url = Api_User_Edit_edit_pay_password;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"password":oldPsd,@"repassword":newPsd}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//获取我的提现余额
+ (void)request_Api_User_Index_get_user_balanceSuccess:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Index_get_user_balance;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    [self get:url parameters:dic success:^(int code, NSString *msg, id data) {
        if ([data isKindOfClass:[NSString class]] &&[data length]<=0) {
            succ(@"0");
            return ;
        }
        succ(data[@"balance"]);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//提现剩余次数
+ (void)request_Api_User_Capital_get_withdraw_infoSuccess:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url = Api_User_Capital_get_withdraw_info;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    [self get:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(data[@"today_last_withdraw_num"]);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}
//联系客服
+ (void)request_Api_Common_Index_kfSuccess:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url =Api_Common_Index_kf;
    [self get:url parameters:nil success:^(int code, NSString *msg, id data) {
        succ(data);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//余额提现
+ (void)request_Api_User_Capital_withdraw:(NetTiXianModelService*)model Success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url =Api_User_Capital_withdraw;
    [self post:url parameters:[model  mj_keyValues] success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}


// 获取我的推广码
+ (void)request_Api_User_Index_get_user_recommend_numSuccess:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url =Api_User_Index_get_user_recommend_num;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(data);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

//填写我的推广人
+ (void)request_Api_User_Edit_set_user_recommend:(NSString*)recommend_code Success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url =Api_User_Edit_set_user_recommend;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"recommend_code":recommend_code}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(msg);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

// 关联手机号
+ (void)request_Api_User_Edit_extends_login_bind_phone:(NSString*)mobile code:(NSString*)code Success:(ResponseSuc)succ error:(ResponseErr)err {
    NSString *url =Api_User_Edit_extends_login_bind_phone;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{@"user_key":User_key,@"mobile":mobile,@"code":code}];
    [self post:url parameters:dic success:^(int code, NSString *msg, id data) {
        succ(data);
    } error:^(int code, NSString *msg) {
        err(msg);
    } failure:^(NSError *failure) {
        
    }];
}

@end


