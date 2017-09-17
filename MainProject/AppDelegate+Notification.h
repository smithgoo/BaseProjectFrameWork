//
//  AppDelegate+Notification.h
//  SpokenEvaluation
//
//  Created by cnsunrun on 2017/4/15.
//  Copyright © 2017年 cnsunrun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Notification)

-(void)registerRemoteNotificationWithLaunchOption:(NSDictionary *)launchOptions;
//设置别名
+(void)registerWithAlias:(NSString *)alias;
@end
