//
//  RHSocketCustom0330Encoder.m
//  RHSocketCustomCodecDemo
//
//  Created by zhuruhong on 16/3/30.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHSocketCustom0330Encoder.h"
#import "RHSocketException.h"
#import "RHSocketUtils.h"
#import "RHSocketCustomRequest.h"

//#import "ChatModel.h"

@interface RHSocketCustom0330Encoder ()
{
//    DBManager* _dbManager;
}

@end

@implementation RHSocketCustom0330Encoder

- (void)encode:(id<RHUpstreamPacket>)upstreamPacket output:(id<RHSocketEncoderOutputProtocol>)output
{
    
    id object = [upstreamPacket object];
    if (![object isKindOfClass:[NSData class]]) {
        [RHSocketException raiseWithReason:@"[Encode] object should be NSData ..."];
        return;
    }
    
    NSData *data = object;
    if (data.length == 0) {
        return;
    }
    
    NSMutableData *sendData = [[NSMutableData alloc] init];
    
    [sendData appendData:data];
    
    NSTimeInterval timeout = [upstreamPacket timeout];
    
    RHSocketLog(@"timeout: %f, sendData: %@", timeout, sendData);
    NSLog(@"detectSocketPacketRequest string发送前: %@", [[NSString alloc] initWithData:sendData encoding:NSUTF8StringEncoding]);
    
//    ChatModel *model = [ChatModel objectWithKeyValues:[[NSString alloc] initWithData:sendData encoding:NSUTF8StringEncoding]];
//    if (model.from_uid && ![model.from_uid isEqualToString:@""]) {
//        
//        if (![model.cmd isEqualToString:@"revocation"]) {
//            
//            [self saveDB:model];
//        }else{
//            
//            [self deleDB:@[model.add_time]];
//        }
//    }
    
    [output didEncode:data timeout:timeout];
}

- (void)deleDB :(NSArray *)models{
//    
//    _dbManager =[DBManager sharedDBManager];
//    
//    [_dbManager delMsgWithIndex:models];
    
}

#pragma mark --保存本地数据库
//- (void)saveDB :(ChatModel *)model{
//
//    _dbManager =[DBManager sharedDBManager];
//    ChatLatestUser *chatLatestUser =[[ChatLatestUser alloc]init];//最新联系人
//    ChatHistoryUser *chatHistoryUser =[[ChatHistoryUser alloc]init];//历史联系人
//    
//    if (![model.from_uid isEqualToString:@""] &&
//        model.from_uid) {
//        
//        User *userModel = [BMAccountManager sharedInstance].user;
//        
//        chatLatestUser.personIndex =[NSString stringWithFormat:@"%@00%@",model.from_uid,model.to_uid];
//        chatLatestUser.fromUid =model.from_uid;
//        chatLatestUser.toUid =model.to_uid;
//        chatLatestUser.fromName =model.from_name;
//        chatLatestUser.toName =model.to_name;
//        chatLatestUser.toIcon =model.to_icon;
//        chatLatestUser.msgType =model.msg_type;
//        chatLatestUser.content =model.content;
//        chatLatestUser.addTime =model.add_time;
//        chatLatestUser.type =model.type;
//        chatLatestUser.fromIcon =model.from_icon;
//        chatLatestUser.netUrl =@"";
//        chatLatestUser.length =@"";
//        chatLatestUser.unreadCout =@"0";
//        
//        NSArray *chatLatestUserArr1 =@[chatLatestUser.personIndex,chatLatestUser.fromUid,chatLatestUser.toUid,chatLatestUser.fromName,chatLatestUser.content,chatLatestUser.addTime,chatLatestUser.toIcon,chatLatestUser.toName,chatLatestUser.msgType,chatLatestUser.type,chatLatestUser.fromIcon,chatLatestUser.netUrl,chatLatestUser.length,chatLatestUser.unreadCout];
//        
//        NSArray *chatLatestUserArr2 =@[chatLatestUser.fromUid,chatLatestUser.toUid,chatLatestUser.fromName,chatLatestUser.content,chatLatestUser.addTime,chatLatestUser.toIcon,chatLatestUser.toName,chatLatestUser.msgType,chatLatestUser.type,chatLatestUser.fromIcon,chatLatestUser.netUrl,chatLatestUser.length,chatLatestUser.unreadCout,chatLatestUser.personIndex];
//        
//        
//        [_dbManager insertChatLatestUser:chatLatestUserArr1 withArg2:chatLatestUserArr2];
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
//        chatHistoryUser.unreadCout =@"0";
//        
//        if (!model.content) {
//            chatHistoryUser.content =@"";
//        }
//        if (!chatHistoryUser.netUrl) {
//            chatHistoryUser.netUrl =@"";
//        }
//        if (!chatHistoryUser.length) {
//            chatHistoryUser.length =@"";
//        }
//    }
//    
//    NSArray *chatHistoryUserArr =@[chatHistoryUser.addTime,chatHistoryUser.ownerSelf,chatHistoryUser.fromName,chatHistoryUser.content,chatHistoryUser.toUid,chatHistoryUser.toIcon,chatHistoryUser.toName,chatHistoryUser.msgType,chatHistoryUser.type,chatHistoryUser.fromUid,chatHistoryUser.fromIcon,chatHistoryUser.netUrl,chatHistoryUser.length,chatHistoryUser.unreadCout];
//    
//    [_dbManager insertChatHistoryUser:chatHistoryUserArr];
//}

@end
