//
//  BaseInfo.m
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "BaseInfo.h"
#import <CommonCrypto/CommonDigest.h>
#import "pinyin.h"
#import <RHSocketService.h>
#import "RHSocketCustom0330Encoder.h"
#import "RHSocketCustom0330Decoder.h"
#import "ConfigInfo.h"
#import "MacroInfo.h"
#import <MJExtension.h>
#import "NSDate+custom.h"
#import <AFNetworking.h>
#import <IQKeyboardManager.h>
#import <SVProgressHUD.h>
#import <MMPopupView.h>
#import <MMAlertView.h>
#import "BMToast.h"
@implementation BaseInfo

#define kHost @"www.baidu.com"
#define MSG_LOAD_GET          @"正在加载"
#define MSG_LOAD_GET_SUC      @"加载成功"
#define MSG_LOAD_SET          @"正在执行"
#define MSG_LOAD_SET_SUC      @"执行成功"
#define MSG_ALERT_LIST_EMPTY  @"暂无数据"
#define MSG_ALERT_NET_FAILURE @"服务器内部异常，请稍后重试"

#define kPort 8080
#pragma mark - 调试

+ (BOOL)isDebug
{
    return YES;
}

#pragma mark - Sockit

+ (void)connectService
{
    //方便多次观察，先停止之前的连接
    [[RHSocketService sharedInstance] stopService];
    
    //这里的服务器对应RHSocketServerDemo，连接之前，需要运行RHSocketServerDemo开启服务端监听。
    //RHSocketServerDemo服务端只是返回数据，收到的数据是原封不动的，用来模拟发送给客户端的数据。
    
    NSString *host = kHost;
    int port = kPort;
    ///-----------
    //变长编解码。包体＝包头（包体的长度）＋包体数据
    RHSocketCustom0330Encoder *encoder = [[RHSocketCustom0330Encoder alloc] init];
    RHSocketCustom0330Decoder *decoder = [[RHSocketCustom0330Decoder alloc] init];
    
    [RHSocketService sharedInstance].encoder = encoder;
    [RHSocketService sharedInstance].decoder = decoder;
    
    [[RHSocketService sharedInstance] startServiceWithHost:host port:port];
}


#pragma mark - 请求

+ (void)autoLogin
{
    NSString *str = [ConfigInfo appUserId];
    NSLog(@"-------appAccountId:%@", str);
    if ([[ConfigInfo appUserId] isEqualToString:@""]) {
        return;
    }
    // 请求获取基础信息
}

+ (void)autoRequestCommon
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"app.provinceNew.plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    id jsonStr = [dictionary objectForKey:@"ProvinceList"];
    if (jsonStr != nil) {
//        [DataInfo shared].commonParameter = [m_Baby_Data_index mj_objectWithKeyValues:jsonStr];
//        [DataInfo shared].provinceList = [DataInfo shared].commonParameter.p_area;
        return;
    }
    if ([BaseInfo isEmptyOrNil:[ConfigInfo appParameterPassword]] || [BaseInfo isEmptyOrNil:[ConfigInfo appUserId]]) {
        return;
    }
//    [NetAccountService request_Baby_Data_index:[ConfigInfo appUserId] password:[ConfigInfo appParameterPassword] success:^(int code, NSString *msg, id systemLocationList) {
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsPath = [paths objectAtIndex:0];
//        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"app.provinceNew.plist"];
//        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
//        [dictionary setObject:systemLocationList
//                       forKey:@"ProvinceList"];
//        [dictionary writeToFile:plistPath atomically:YES];
//        m_Baby_Data_index *model = [m_Baby_Data_index mj_objectWithKeyValues:systemLocationList];
//        [DataInfo shared].provinceList = model.p_area;
//        [DataInfo shared].commonParameter = model;
//    } error:^(int code, NSString *msg) {
//        [BaseInfo showErrorMessage:msg];
//    }];
}

#pragma mark - 图片处理
+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

+ (NSData *)compressImageData:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}

#pragma mark - 文本框

+ (UIView *)getTextFieldLeftView:(NSString *)imageName width:(float)width height:(float)height
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width-image.size.width)/2, (height-image.size.height)/2, image.size.width, image.size.height)];
    imageView.image = image;
    [leftView addSubview:imageView];
    return leftView;
}

+ (UIView *)getTextFieldLeftView:(NSString *)imageName width:(float)width height:(float)height bgColor:(UIColor *)bgColor
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width-image.size.width)/2, (height-image.size.height)/2, image.size.width, image.size.height)];
    imageView.image = image;
    [leftView addSubview:imageView];
    leftView.backgroundColor = bgColor;
    return leftView;
}

+ (UIView *)getTextFieldLeftView:(NSString *)imageName width:(float)width height:(float)height bgColor:(UIColor *)bgColor offsetX:(float)offsetX
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width + offsetX, height)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width-image.size.width)/2, (height-image.size.height)/2, image.size.width, image.size.height)];
    imageView.image = image;
    [leftView addSubview:imageView];
    leftView.backgroundColor = bgColor;
    
    UIView *offsetView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, offsetX, height)];
    offsetView.backgroundColor = [UIColor whiteColor];
    [leftView addSubview:offsetView];
    
    return leftView;
}

+ (void)setTextFieldInset:(UITextField *)txt left:(float)left
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, left, 5)];
    txt.leftView = view;
    txt.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - 颜色处理

+ (BOOL)isDarkColor:(UIColor *)newColor {
    if ([self alphaForColor:newColor] < 10e-5) {
        return YES;
    }
    const CGFloat *componentColors = CGColorGetComponents(newColor.CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    if (colorBrightness < 0.5) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (CGFloat) alphaForColor:(UIColor*)color {
    CGFloat r, g, b, a, w, h, s, l;
    BOOL compatible = [color getWhite:&w alpha:&a];
    if (compatible) {
        return a;
    }
    else {
        compatible = [color getRed:&r green:&g blue:&b alpha:&a];
        if (compatible) {
            return a;
        }
        else {
            [color getHue:&h saturation:&s brightness:&l alpha:&a];
            return a;
        }
    }
}

#pragma mark - 字符串

+ (NSMutableAttributedString *)getUnderlineString:(NSString *)contentString
{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:contentString];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    return content;
}

+ (NSMutableAttributedString *)getDeletelineString:(NSString *)contentString
{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:contentString];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    return content;
}

+ (NSString *)replaceStartEndString:(NSString *)text str:(NSString *)str
{
    if (text.length >= 2) {
        NSString *start = [text substringToIndex:1];
        NSString *end = [text substringFromIndex:text.length-1];
        return [NSString stringWithFormat:@"%@%@%@%@", start, str, str, end];
    }
    else if (text.length == 1) {
        return [NSString stringWithFormat:@"%@%@%@%@", text, str, str, text];
    }
    else {
        return @"天风中小";
    }
}

+ (NSString *)getFirstLetter:(NSString *)text
{
    if (text.length > 0) {
        return [km_mstr(@"%c", pinyinFirstLetter([text characterAtIndex:0])) uppercaseString];
    }
    else {
        return @"";
    }
}

+ (BOOL)isEmptyOrNil:(NSString *)text {
    if (text == nil || [text isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (NSString *)getJsonStringFromModelList:(NSArray *)array {
    NSString *jsonString = @"";
    for (int i = 0; i < array.count; i++) {
        id model = [array objectAtIndex:i];
        if ([jsonString isEqualToString:@""]) {
            jsonString = [model mj_JSONString];
        }
        else {
            jsonString = km_str(@"%@,%@", jsonString, [model mj_JSONString]);
        }
    }
    jsonString = km_str(@"[%@]", jsonString);
    return jsonString;
}

+ (NSString *)objArrayToJSON:(NSArray *)array {
    
    NSString *jsonStr = @"[";
    
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = km_str(@"%@%@%@", @"\"",jsonStr, @"\"");
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    
    return jsonStr;
}

+ (NSString *)getDistanceString:(NSNumber *)distance {
    if (distance.floatValue < 0.2) {
        return @"<200m";
    }
    else if (distance.floatValue >= 0.2 && distance.floatValue < 1.0) {
        return km_str(@"%0.0fm", distance.floatValue*1000.0f);
    }
    else {
        return km_str(@"%0.2fkm", distance.floatValue);
    }
}

+ (NSString *)getDateTimeFriendString:(NSString *)dateTimeString {
    NSDate *date = [BaseInfo getDateFromString:dateTimeString];
    NSInteger minutes = [date minutesBeforeDate:[NSDate date]];
    if (minutes <= 0) {
        return @"刚刚";
    }
    else if (minutes > 0 && minutes <= 60) {
        return km_str(@"%d分钟之前", (int)minutes);
    }
    else if (minutes > 60 && minutes <= 60*24) {
        NSInteger hours = [date hoursBeforeDate:[NSDate date]];
        return km_str(@"%d小时之前", (int)hours);
    }
    else if (minutes > 60*24 && minutes <= 60*24*10) {
        NSInteger days = [date daysBeforeDate:[NSDate date]];
        return km_str(@"%d天之前", (int)days);
    }
    else {
        return [date stringWithFormat:@"yyyy-MM-dd"];
    }
}

+ (CGSize)getTextSize:(NSString *)text withMaxSize:(CGSize)size withFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}

+ (void)ColorWithRed:(UILabel *)lable
{
    if ([lable.text containsString:@"*"]) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:lable.text];
        NSRange range = [lable.text rangeOfString:@"*"];
        [attStr setAttributes:@{NSForegroundColorAttributeName:km_rgb_hex(0xd52b33)} range:range];
        [lable setAttributedText:attStr];
    }
}

+ (void)ColorWithBlack:(UILabel *)lable WithAttStr:(NSString *)attStr
{
    if ([lable.text containsString:attStr]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lable.text];
        NSRange range = [lable.text rangeOfString:attStr];
        [str setAttributes:@{NSForegroundColorAttributeName:km_rgb_hex(0x999999)} range:range];
        [lable setAttributedText:str];
    }
}

#pragma mark - 日期

+ (NSString *)getDateTimeFromString:(NSString *)string
{
    NSTimeInterval time= [string doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)getStringFromDate:(NSDate *)date format:(NSString *)format
{
    if (date == nil) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getStringFromDateString:(NSString *)dateString format:(NSString *)format
{
    NSDate *date = [self getDateFromString:dateString];
    if (date) {
        return [self getStringFromDate:date format:format];
    }
    else {
        return dateString;
    }
}

+ (NSDate *)getDateFromString:(NSString *)string
{
    if ([string isEqualToString:@""] || string == nil) {
        return nil;
    }
    
    if ([string rangeOfString:@"-"].length > 0 && [string rangeOfString:@":"].length > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:string];
        return date;
    }
    
    if ([string rangeOfString:@"/"].length > 0 && [string rangeOfString:@":"].length > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:string];
        return date;
    }
    
    //微软时间格式字符串
    NSCharacterSet *setNum = [NSCharacterSet decimalDigitCharacterSet];
    NSRange numRange = [string rangeOfCharacterFromSet:setNum];
    numRange.length = [string length] - numRange.location - 2;
    NSString *numString = [string substringWithRange:numRange];
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [numberFormatter numberFromString:numString];
    double time = [number doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    return date;
}

+ (NSString *)ageWithDateOfBirth:(NSDate *)dateBithday;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    
    NSDate *nowDate = [NSDate date];
    
    NSDate *birthDay = dateBithday;
    //用来得到详细的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:nowDate options:0];
    
    if([date year] > 0){
        return [NSString stringWithFormat:(@"%ld岁%ld月%ld天"),(long)[date year],(long)[date month],(long)[date day]];
    }else if([date month] >0){
        return [NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]];
    }else if([date day]>0){
        return [NSString stringWithFormat:(@"%ld天"),(long)[date day]];
    }else {
        return @"0天";
    }
}

#pragma mark - 网络

+ (void)startMonitoringNetwork
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([self isDebug]) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (BOOL)checkMonitoringNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark - 键盘

+ (void)startKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

#pragma mark - 加密解密

+ (NSString *)md5HexDigest:(NSString*)input
{
    const char *str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret.uppercaseString;
}

#pragma mark - 消息提示

+ (void)setMessageStyle
{
//    [[TSMessageView appearance] setDuration:3.0];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [[MMAlertViewConfig globalConfig] setDefaultTextOK:@"确认"];
    [[MMAlertViewConfig globalConfig] setDefaultTextCancel:@"取消"];
    [[MMAlertViewConfig globalConfig] setDefaultTextConfirm:@"确认"];
}

+ (void)showLoadingMessage
{
    [SVProgressHUD showWithStatus:MSG_LOAD_GET];
}

+ (void)showExecuteMessage
{
    [SVProgressHUD showWithStatus:MSG_LOAD_SET];
}

+ (void)showSuccessMessage:(NSString *)message
{
    [self hideMessage];
    [BMToast makeText:message];
//   [TSMessage showNotificationWithTitle:@"提示"
//                                subtitle:message
//                                    type:TSMessageNotificationTypeSuccess];
}

+ (void)showErrorMessage:(NSString *)message
{
    [self hideMessage];
    [BMToast makeText:message];
//    [TSMessage showNotificationWithTitle:@"提示"
//                                subtitle:message
 //                                   type:TSMessageNotificationTypeError];
}

+ (void)showInfomationMessage:(NSString *)message
{
    [self hideMessage];
//    [TSMessage showNotificationWithTitle:@"提示"
//                                subtitle:message
//                                    type:TSMessageNotificationTypeMessage];
}

+ (void)hideMessage
{
    [SVProgressHUD dismiss];
}

#pragma mark - 二维码以及条形码
// 参考文档
// https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html

+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成条形码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

+ (NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

+ (NSString*)deCodeWithString:(NSString*)str {
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:str options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

+(NSString *)base64EncodeString:(NSString *)string

{
    
    //1.先把字符串转换为二进制数据
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.对二进制数据进行base64编码，返回编码后的字符串
    return [data base64EncodedStringWithOptions:0];
    
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//编码
+(NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
//解码
+(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

@end
