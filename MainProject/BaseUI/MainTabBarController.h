//
//  MainTabBarController.h
//  findbabyapp
//
//  Created by Mike on 2016/12/13.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController<UITabBarDelegate>
//客户登录的角色 用户  商家  媒体  1 2 3
@property (nonatomic,strong)NSString *CustomerFlag;

@property (nonatomic, strong) id launchVC;
@end
