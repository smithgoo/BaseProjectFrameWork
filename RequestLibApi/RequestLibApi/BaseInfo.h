//
//  BaseInfo.h
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BaseInfo : NSObject

#pragma mark - 调试
+ (BOOL)isDebug;

#pragma mark --开启socket网络服务
+ (void)connectService;
#pragma mark - 请求
+ (void)autoLogin;
+ (void)autoRequestCommon;

#pragma mark - 图片处理
+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
+ (NSData *)compressImageData:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

#pragma mark - 文本框
+ (UIView *)getTextFieldLeftView:(NSString *)imageName width:(float)width height:(float)height;
+ (UIView *)getTextFieldLeftView:(NSString *)imageName width:(float)width height:(float)height bgColor:(UIColor *)bgColor;
+ (UIView *)getTextFieldLeftView:(NSString *)imageName width:(float)width height:(float)height bgColor:(UIColor *)bgColor offsetX:(float)offsetX;
+ (void)setTextFieldInset:(UITextField *)txt left:(float)left;

#pragma mark - 颜色处理
+ (BOOL)isDarkColor:(UIColor *)newColor;
+ (UIColor *)colorWithHexString:(NSString *)color;
#pragma mark - 字符串
+ (NSMutableAttributedString *)getUnderlineString:(NSString *)contentString;
+ (NSMutableAttributedString *)getDeletelineString:(NSString *)contentString;
+ (NSString *)replaceStartEndString:(NSString *)text str:(NSString *)str;
+ (NSString *)getFirstLetter:(NSString *)text;
+ (BOOL)isEmptyOrNil:(NSString *)text;
+ (NSString *)getJsonStringFromModelList:(NSArray *)array;
+ (NSString *)objArrayToJSON:(NSArray *)array;
+ (NSString *)getDistanceString:(NSNumber *)distance;
+ (NSString *)getDateTimeFriendString:(NSString *)dateTimeString;
+ (CGSize)getTextSize:(NSString *)text withMaxSize:(CGSize)size withFont:(UIFont *)font;

+ (void)ColorWithRed:(UILabel *)lable;

+ (void)ColorWithBlack:(UILabel *)lable WithAttStr:(NSString *)attStr;

#pragma mark - 日期
+ (NSString *)getDateTimeFromString:(NSString *)string;
+ (NSString *)getStringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSString *)getStringFromDateString:(NSString *)dateString format:(NSString *)format;
+ (NSDate *)getDateFromString:(NSString *)string;

+ (NSString *)ageWithDateOfBirth:(NSDate *)date;


#pragma mark - 网络
+ (void)startMonitoringNetwork;
+ (BOOL)checkMonitoringNetwork;

#pragma mark - 键盘
+ (void)startKeyboardManager;

#pragma mark - 加密解密
+ (NSString *)md5HexDigest:(NSString*)input;

#pragma mark - 消息提示
+ (void)setMessageStyle;
+ (void)showLoadingMessage;
+ (void)showExecuteMessage;
+ (void)showSuccessMessage:(NSString *)message;
+ (void)showErrorMessage:(NSString *)message;
+ (void)showInfomationMessage:(NSString *)message;
+ (void)hideMessage;

#pragma mark - 二维码以及条形码
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;
+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

+ (NSString*)DataTOjsonString:(id)object;

+ (NSString *)JSONString:(NSString *)aString;

+ (NSString*)deCodeWithString:(NSString*)str;

+(NSString *)base64EncodeString:(NSString *)string;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//编码
+(NSString *)URLEncodedString:(NSString *)str;

@end
