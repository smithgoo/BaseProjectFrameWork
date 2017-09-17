//
//  AppDelegate+MobShare.h
//  MainProject
//
//  Created by 王朋 on 2017/5/11.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (MobShare)

//配置分享信息
- (void)configurationToShareInformation;

/**
 分享调用的方法 不填为空
 
 @param imageName 分享的一张大图
 @param shareUrl 需要分享的URL
 @param shareTitle 分享的标题
 @param ContentText 分享的内容
 */
+ (void)sharingMethodCall:(NSString*)imageName  shareUrl:(NSString *)shareUrl  shareTitle:(NSString*)shareTitle shareContent:(NSString*)ContentText;

@end
