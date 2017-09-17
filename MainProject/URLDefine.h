//
//  URLDefine.h
//  MainProject
//
//  Created by cnsunrun on 2017/5/26.
//  Copyright © 2017年 app_developer@sina.com. All rights reserved.
//

#ifndef URLDefine_h
#define URLDefine_h

#define URLString(urlStr)  [NSString stringWithFormat:@"%@%@", HOST, urlStr]

#ifdef DEBUG
/**
 测试服务器地址
 */
#define HOST   @"http://test.cnsunrun.com/shunshou"

#else
/**
 正式服务器地址
 */
#define HOST    /*@"http://test.cnsunrun.com/ssxh/code/"*/ @"http://139.224.117.199/"
#endif

#pragma mark - 个人信息

/**
 用户-个人中心
 */
#define Api_User_Index_get_user_info URLString(@"/Api/User/Index/get_user_info")


//发送验证码
#define Api_Login_Index_login_code  URLString(@"/Api/Login/Index/login_code")

//手机号登录
#define  Api_Login_Index_login  URLString(@"/Api/Login/Index/login")


//意见反馈
#define Api_Feekback_Index_add  URLString(@"/Api/Feekback/Index/add")

//关于我们
#define Home_Index_Public_about   URLString(@"/Home/Index/Public/about.html")

//我发布的评价
#define Api_User_Evaluation_my_send_list   URLString(@"/Api/User/Evaluation/my_send_list")



//我收到的评价
#define Api_User_Evaluation_my_receive_list   URLString(@"/Api/User/Evaluation/my_receive_list")

//删除评价
#define Api_User_Evaluation_del_my_send URLString(@"/Api/User/Evaluation/del_my_send")


//我的头衔
#define Api_User_Index_get_user_title URLString(@"/Api/User/Index/get_user_title")

//编辑我的头衔
#define Api_User_Edit_edit_title URLString(@"/Api/User/Edit/edit_title")

//获取我的余额
#define Api_User_Index_get_user_balance URLString(@"/Api/User/Index/get_user_balance")

//编辑头像
#define Api_User_Edit_edit_headimg URLString(@"/Api/User/Edit/edit_headimg")
//编辑昵称

#define Api_User_Edit_edit_nickname URLString(@"/Api/User/Edit/edit_nickname")

//编辑个性签名

#define Api_User_Edit_edit_signature URLString(@"/Api/User/Edit/edit_signature")

//编辑技能

#define Api_User_Edit_edit_skill URLString(@"/Api/User/Edit/edit_skill")

//编辑爱好

#define  Api_User_Edit_edit_hobbies URLString(@"/Api/User/Edit/edit_hobbies")

//编辑年龄

#define  Api_User_Edit_edit_age URLString(@"/Api/User/Edit/edit_age")
//编辑性别
#define Api_User_Edit_edit_gender URLString(@"/Api/User/Edit/edit_gender")
//换绑手机号验证码
#define Api_User_Edit_send_bind_mobile_code URLString(@"/Api/User/Edit/send_bind_mobile_code")

//验证就手机号
#define Api_User_Edit_bind_phone_by_code_two URLString(@"/Api/User/Edit/bind_phone_by_code_two")

//换绑手机号
#define Api_User_Edit_bind_phone URLString(@"/Api/User/Edit/bind_phone")

//我的相册
#define Api_User_Index_get_user_photo URLString(@"/Api/User/Index/get_user_photo")

//添加照片

#define Api_User_Edit_add_photo URLString(@"/Api/User/Edit/add_photo")

//删除照片
#define Api_User_Edit_del_photo URLString(@"/Api/User/Edit/del_photo")


//获取附近首页信息
#define Api_Common_Index_home URLString(@"/Api/Common/Index/home")


//获取用户基础信息
#define Api_Order_User_get_user_base_info  URLString(@"/Api/Order/User/get_user_base_info")

//获取用户个性信息
#define Api_Order_User_get_user_extend_info  URLString(@"/Api/Order/User/get_user_extend_info")

//获取用户评价
#define Api_Order_User_get_user_evaluation  URLString(@"/Api/Order/User/get_user_evaluation")

//获取用户相册
#define Api_Order_User_get_user_view_photo  URLString(@"/Api/Order/User/get_user_view_photo")

//订单详情
#define Api_Order_Index_order_info  URLString(@"/Api/Order/Index/order_info")

//获取充值订单号
#define Api_User_Capital_create_recharge_order URLString(@"/Api/User/Capital/create_recharge_order")

//提现页面
#define Api_User_Capital_get_withdraw_info  URLString(@"/Api/User/Capital/get_withdraw_info")

//举报
#define Api_Order_Index_report  URLString(@"/Api/Order/Index/report")

//接受订单
#define Api_Order_Index_receive  URLString(@"/Api/Order/Index/receive")

//获取历史搜索数据
#define Api_Common_Index_history_keywords  URLString(@"/Api/Common/Index/history_keywords")

//删除历史数据
#define Api_Common_Index_del_keyword  URLString(@"/Api/Common/Index/del_keyword")

//获取支付密码手机号
#define Api_User_Edit_edit_pay_password_one  URLString(@"/Api/User/Edit/edit_pay_password_one")

//修改支付密码 发送验证码
#define Api_User_Edit_edit_pay_password_by_send_code  URLString(@"/Api/User/Edit/edit_pay_password_by_send_code")

//修改支付密码-验证手机号
#define Api_User_Edit_edit_pay_password_by_check_code  URLString(@"/Api/User/Edit/edit_pay_password_by_check_code")

//修改支付密码
#define Api_User_Edit_edit_pay_password  URLString(@"/Api/User/Edit/edit_pay_password")

// 个人中心获取我的余额
#define Api_User_Index_get_user_balance  URLString(@"/Api/User/Index/get_user_balance")

//提现剩余次数
#define Api_User_Capital_get_withdraw_info  URLString(@"/Api/User/Capital/get_withdraw_info")

//发布订单
#define Api_Order_Index_create_order  URLString(@"/Api/Order/Index/create_order")
//我发布的订单列表
#define Api_Order_User_my_send_order_list  URLString(@"/Api/Order/User/my_send_order_list")

//我接受的订单列表
#define Api_Order_User_my_receive_order_list  URLString(@"/Api/Order/User/my_receive_order_list")

//联系客服
#define  Api_Common_Index_kf URLString(@"/Api/Common/Index/kf")

//余额提现
#define  Api_User_Capital_withdraw URLString(@"/Api/User/Capital/withdraw")


//我发布的订单详情
#define Api_Order_User_my_send_order_details URLString(@"/Api/Order/User/my_send_order_details")
//我接收的订单详情
#define Api_Order_User_my_receive_order_details URLString(@"/Api/Order/User/my_receive_order_details")
//发布任务的最低赏金
#define Api_Order_Index_get_order_free URLString(@"/Api/Order/Index/get_order_free")

//余额支付

#define Api_Pay_Callback_default_callback  URLString(@"/Api/Pay/Callback/default_callback")

//获取评价标签
#define Api_Order_Comment_get_tag_lis  URLString(@"/Api/Order/Comment/get_tag_list")

//发布评论
#define Api_Order_Comment_send  URLString(@"/Api/Order/Comment/send")

//第三方登录
#define Api_Login_Index_extract_login  URLString(@"/Api/Login/Index/extract_login")

//取消任务
#define Api_Order_User_cancel_order  URLString(@"/Api/Order/User/cancel_order")

//确认完成 (发布人)
#define Api_Order_User_member_complete_order  URLString(@"/Api/Order/User/member_complete_order")

//确认完成 (接受人)
#define Api_Order_User_seller_complete_order  URLString(@"/Api/Order/User/seller_complete_order")

//选他了 (发布人)
#define Api_Order_User_my_send_order_select_us  URLString(@"/Api/Order/User/my_send_order_select_us")

//获取我的推广码
#define Api_User_Index_get_user_recommend_num  URLString(@"/Api/User/Index/get_user_recommend_num")

//填写我的推广人
#define Api_User_Edit_set_user_recommend  URLString(@"/Api/User/Edit/set_user_recommend")

//三方登录关联手机号
#define Api_User_Edit_extends_login_bind_phone  URLString(@"/Api/User/Edit/extends_login_bind_phone")

// 订单确认
#define Api_Order_Index_get_pay_config  URLString(@"/Api/Order/Index/get_pay_config")

//预支付id

#define Api_Order_Index_get_wxpay_id URLString(@"/Api/Order/Index/get_wxpay_id")


#endif /* URLDefine_h */

#pragma mark - block 样式

/**
 成功 block 样式

 @param data 返回数据
 */
typedef void(^ResponseSuc)(id data);

/**
 成功 block 样式
 
 @param data 返回数据
 */
typedef void(^ResponseResult)(int code,NSString *msg,id data);


/**
 成功 block 样式
 
 @param msg 返回数据
 */
typedef void(^ResponseResultErr)(int code,NSString *msg);

/**
  请求失败 block 样式

 @param errMsg 返回错误信息
 */
typedef void(^ResponseErr)(NSString *errMsg);
