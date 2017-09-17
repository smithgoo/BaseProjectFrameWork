//
//  RHSocketCustom0330Decoder.m
//  RHSocketCustomCodecDemo
//
//  Created by zhuruhong on 16/3/30.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHSocketCustom0330Decoder.h"
#import "RHSocketException.h"
#import "RHSocketUtils.h"
#import "RHSocketCustomResponse.h"
//#import "ChatModel.h"
@interface RHSocketCustom0330Decoder ()
{
    NSUInteger _countOfLengthByte;
//    DBManager* _dbManager;
}

@end

@implementation RHSocketCustom0330Decoder

- (instancetype)init
{
    if (self = [super init]) {
        _countOfLengthByte = 8;
        
    }
    return self;
}

- (NSInteger)decode:(id<RHDownstreamPacket>)downstreamPacket output:(id<RHSocketDecoderOutputProtocol>)output
{
    
    id object = [downstreamPacket object];
    if (![object isKindOfClass:[NSData class]]) {
        [RHSocketException raiseWithReason:@"[Decode] object should be NSData ..."];
        return -1;
    }
    
    NSData *downstreamData = object;
    NSLog(@"detectSocketPacketResponse string: %@", [[NSString alloc] initWithData:object encoding:NSUTF8StringEncoding]);
    
    
    NSString *receivedata =[[NSString alloc] initWithData:downstreamData encoding:NSUTF8StringEncoding];
    NSArray *arr = [receivedata componentsSeparatedByString:@"\n"];
    NSMutableArray *addModels =[NSMutableArray array];
    NSMutableArray *delModels =[NSMutableArray array];
//    for (NSString *str in arr) {
//        ChatModel *model = [ChatModel objectWithKeyValues:str];
//        if (model.from_uid && ![model.from_uid isEqualToString:@""]) {
//            
//            if (![model.cmd isEqualToString:@"revocation"]) {
//                
//                [addModels addObject:model];
//            }else{
//                
//                [delModels addObject:model];
//            }
//        }
//    }
//    
    [self saveDB:addModels withDelModels:delModels];
    
    RHSocketCustomResponse *rsp = [[RHSocketCustomResponse alloc] init];
    rsp.object = downstreamData;
    [output didDecode:rsp];
    return downstreamData.length;
}


#pragma mark --保存本地数据库
- (void)saveDB :(NSArray *)models withDelModels:(NSArray *)delModels{
    
//    _dbManager =[DBManager sharedDBManager];
    NSMutableArray *chatLatestUsers =[NSMutableArray array];
    NSMutableArray *chatLatestUsers1 =[NSMutableArray array];
    NSMutableArray *chatHistoryUsers =[NSMutableArray array];
    
    /*
     
     NSString *insertSql = @"insert into ChatLatestUser(personIndex ,  fromUid  ,  toUid ,  fromName ,  content ,  addTime ,  toIcon ,  toName ,  msgType ,  type ,  fromIcon ,  netUrl ,  length ,  unreadCout )
     */
//    for (ChatModel *model in models) {
//        
//        User *userModel = [BMAccountManager sharedInstance].user;
//        ChatLatestUser *chatLatestUser =[[ChatLatestUser alloc]init];//最新联系人
//        ChatHistoryUser *chatHistoryUser =[[ChatHistoryUser alloc]init];//历史联系人
//        
//        //        chatLatestUser.hostID =[[NSString stringWithFormat:@"%@00%@",model.to_uid,model.from_uid] integerValue];
//        chatLatestUser.personIndex =[NSString stringWithFormat:@"%@00%@",model.to_uid,model.from_uid];
//        chatLatestUser.fromUid =model.from_uid;
//        chatLatestUser.toUid =model.to_uid;
//        chatLatestUser.fromName =model.from_name;
//        chatLatestUser.content =model.content;
//        chatLatestUser.addTime =model.add_time;
//        chatLatestUser.toIcon =model.to_icon;
//        chatLatestUser.toName =model.to_name;
//        chatLatestUser.msgType =model.msg_type;
//        chatLatestUser.type =model.type;
//        chatLatestUser.fromIcon =model.from_icon;
//        chatLatestUser.netUrl =@"";
//        chatLatestUser.length =@"";
//        chatLatestUser.unreadCout =@"0";
//        NSArray *chatLatestUserArr =@[chatLatestUser.personIndex,chatLatestUser.fromUid,chatLatestUser.toUid,chatLatestUser.fromName,chatLatestUser.content,chatLatestUser.addTime,chatLatestUser.toIcon,chatLatestUser.toName,chatLatestUser.msgType,chatLatestUser.type,chatLatestUser.fromIcon,chatLatestUser.netUrl,chatLatestUser.length,chatLatestUser.unreadCout];
//        
//        NSArray *chatLatestUserArr1 =@[chatLatestUser.fromUid,chatLatestUser.toUid,chatLatestUser.fromName,chatLatestUser.content,chatLatestUser.addTime,chatLatestUser.toIcon,chatLatestUser.toName,chatLatestUser.msgType,chatLatestUser.type,chatLatestUser.fromIcon,chatLatestUser.netUrl,chatLatestUser.length,chatLatestUser.unreadCout,chatLatestUser.personIndex];
//        
//        [chatLatestUsers addObject:chatLatestUserArr];
//        [chatLatestUsers1 addObject:chatLatestUserArr1];
//        
//        if ([userModel.home_member_id isEqualToString:model.from_uid]) {
//            
//            chatHistoryUser.ownerSelf =@"0";//自己
//        }else{
//            
//            chatHistoryUser.ownerSelf =@"1";//他人
//        }
//        chatHistoryUser.fromName =model.from_name;
//        chatHistoryUser.content =model.content;
//        chatHistoryUser.toUid =model.to_uid;
//        chatHistoryUser.addTime =model.add_time;
//        chatHistoryUser.toIcon =model.to_icon;
//        chatHistoryUser.toName =model.to_name;
//        chatHistoryUser.msgType =model.msg_type;
//        chatHistoryUser.type =model.type;
//        chatHistoryUser.fromUid =model.from_uid;
//        chatHistoryUser.fromIcon =model.from_icon;
//        chatHistoryUser.netUrl =model.net_url;
//        chatHistoryUser.length =model.length;
//        chatHistoryUser.unreadCout =@"1";
//        
//        if (!chatHistoryUser.content) {
//            chatHistoryUser.content =@"";
//        }
//        if (!chatHistoryUser.netUrl) {
//            chatHistoryUser.netUrl =@"";
//        }
//        if (!chatHistoryUser.length) {
//            chatHistoryUser.length =@"";
//        }
//        
//        NSArray *chatHistoryUserArr =@[chatHistoryUser.addTime,chatHistoryUser.ownerSelf,chatHistoryUser.fromName,chatHistoryUser.content,chatHistoryUser.toUid,chatHistoryUser.toIcon,chatHistoryUser.toName,chatHistoryUser.msgType,chatHistoryUser.type,chatHistoryUser.fromUid,chatHistoryUser.fromIcon,chatHistoryUser.netUrl,chatHistoryUser.length,chatHistoryUser.unreadCout];
//        [chatHistoryUsers addObject:chatHistoryUserArr];
//    }
//    
//    
//    
//    [_dbManager insertData:(int)chatHistoryUsers.count withChatLatestUserArr:chatLatestUsers withChatLatestUserArr1:chatLatestUsers1 withChatHistoryUserArr:chatHistoryUsers withDelChatHistoryUserArr:delModels useTransaction:YES];
    
}


//#pragma mark --发送本地通知
//- (void)postNotification: (ChatModel *)model witTime:(NSInteger)alertTime{
//    
//    if (![model.from_uid isEqualToString:@""] &&
//        model.from_uid) {
//        NSString *infoStr;
//        if ([model.msg_type isEqualToString:@"TEXT"]) {
//            infoStr =model.content;
//        }
//        else if ([model.msg_type isEqualToString:@"IMAGE"]) {
//            infoStr =[NSString stringWithFormat:@"%@发来一张图片",model.from_name];
//        }
//        else  if ([model.msg_type isEqualToString:@"VOICE"]) {
//            infoStr =[NSString stringWithFormat:@"%@发来一段语音",model.from_name];
//        }
//        
//        UILocalNotification *localNote = [[UILocalNotification alloc] init];
//        // 设置触发通知的时间
//        NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
//        NSLog(@"fireDate=%@",fireDate);
//        
//        localNote.fireDate = fireDate;
//        // 时区
//        localNote.timeZone = [NSTimeZone defaultTimeZone];
//        
//        // 1.2.设置弹出的内容
//        localNote.alertBody = infoStr;
//        
//        // 1.6.设置音效
//        localNote.soundName = UILocalNotificationDefaultSoundName;
//        
//        // 1.7.应用图标右上角的提醒数字
//        localNote.applicationIconBadgeNumber = ++[UIApplication sharedApplication].applicationIconBadgeNumber;
//        
//        // ios8后，需要添加这个注册，才能得到授权
//        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//            UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
//            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
//                                                                                     categories:nil];
//            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//            // 通知重复提示的单位，可以是天、周、月
//            localNote.repeatInterval = 0;
//        } else {
//            // 通知重复提示的单位，可以是天、周、月
//            localNote.repeatInterval = 0;
//        }
//        
//        // 2.调度通知
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
//    }
//    
//}

@end
