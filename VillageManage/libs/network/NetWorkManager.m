//
//  NetWorkManager.m
//  dengjibao
//
//  Created by Wenlong on 14-4-9.
//  Copyright (c) 2014年 wenlong. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "SecurityData.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NetWorkManager

static NSString* urlBase = @"http://bohan.healbest.com/webservice/";
static NSString* m_sVersion = @"1.0";
static NSString* m_sDeviceType = @"iOS";
#define m_sDeviceNo [SecurityData deviceId]

#define SAVE_FILE @"test.plist"

#define USERID_KEY @"ID"
#define USERNAME_KEY @"UserName"
#define USERMOBILE_KEY @"Mobile"

static NetWorkManager* instance = nil;

+ (NSString*)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (void)Call:(NSString *)num
{
    if ([num length] <= 0) {
        return;
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@", num];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (void) SET_IF_NOT_NIL:(NSMutableDictionary*)dic :(NSString*)key :(id)value
{
    if (value != nil)
    {
        dic[key] = value;
    }
}

+ (void)SetUserInfo:(NSDictionary *)info
{
    m_pUserId = info[USERID_KEY];
    m_pUserName = info[USERNAME_KEY];
    
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithDictionary:@{}];
    
    if (m_pUserId) {
        [NetWorkManager SET_IF_NOT_NIL:userInfo :USERID_KEY :m_pUserId];
        [NetWorkManager SET_IF_NOT_NIL:userInfo :USERNAME_KEY :m_pUserName];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:SAVE_FILE];
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:filename contents:nil attributes:nil];
    
    //创建一个dic，写到plist文件里
    [userInfo writeToFile:filename atomically:YES];
    
    
    userInfo = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSLog(@"========> %@", userInfo);
}

+ (void) InitUserInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:SAVE_FILE];
    NSDictionary* userInfo = [NSDictionary dictionaryWithContentsOfFile:filename];
    
    if (userInfo && userInfo[USERID_KEY])
    {
        [NetWorkManager SetUserInfo:userInfo];
    }
}

NM_PROPERTY_DEFINE(NSString*, UserId);
NM_PROPERTY_DEFINE(NSString*, UserName);
NM_PROPERTY_DEFINE(NSArray*, NewOrderList);
NM_PROPERTY_DEFINE(NSArray*, ConfirmedOrderList);
NM_PROPERTY_DEFINE(NSArray*, FinishedOrderList);
NM_PROPERTY_DEFINE(NSDictionary*, CurOrderInfo);
NM_PROPERTY_DEFINE(NSDictionary*, CurMsgInfo);
NM_PROPERTY_DEFINE(NSString*, OrderAddr);

//----------------------------------------------

+ (NSString*)formatWithDict:(NSDictionary*)dict
{
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONReadingMutableLeaves error:nil];
    NSString* res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"formatWithDict: %@", res);
    
    return res;
}

+ (void)Req:(NSString *)path Method:(NSString*)method withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"Charset"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    SuccessCallBack successWrap = ^(AFHTTPRequestOperation *operation, id responseObject) {
        [AppDelegate HideLoading];
        NSLog(@"success! %@", operation.responseString);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"res: %@", dic);
        if ([dic[@"ok"] isEqualToString:@"FALSE"]) {
            [AppDelegate ShowTips:[NSString stringWithFormat:@"%@", dic[@"reason"]]];
            success(operation, nil);
        } else {
            success(operation, [NSString stringWithFormat:@"%@", dic[@"reason"]]);
            [AppDelegate ShowToast:@"Load Completed!"];
        }
    };
    
    FailureCallBack failWrap = ^(AFHTTPRequestOperation *operation, id responseObject){
        [AppDelegate HideLoading];
        NSLog(@"failed! %@ error %@", operation.responseString, operation.error);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        [AppDelegate ShowTips:[NSString stringWithFormat:@"%@", dic[@"reason"]]];
        failure(operation, responseObject);
    };
    
    if ([method isEqualToString:@"POST"]) {
        [manager POST:[NSString stringWithFormat:@"%@%@", urlBase, path] parameters:params success:successWrap failure:failWrap];
    } else if ([method isEqualToString:@"GET"]) {
        [manager GET:[NSString stringWithFormat:@"%@%@", urlBase, path] parameters:params success:successWrap failure:failWrap];
    }
    
    NSLog(@"\n%@ %@%@\nparam %@", method, urlBase, path, params);
    
    [AppDelegate ShowLoading];
}

+ (void)POST:(NSString *)path withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    [NetWorkManager Req:path Method:@"POST" withParameters:params success:success failure:failure];
}

+ (void)GET:(NSString *)path withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    [NetWorkManager Req:path Method:@"GET" withParameters:params success:success failure:failure];
}

+ (NSData*) rsaEncryptString:(NSString*) string
{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString*) GetTodayDate
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    return [fmt stringFromDate:[NSDate date]];
}

+ (void)TestProtocolWithSuccess:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    NSDictionary* param = @{
                            @"mobile": @"13656663390",
                            @"pwd": @"123456",
                            };
    [NetWorkManager POST:@"Service.asmx/User_Check" withParameters:param success:success failure:failure];
}

+ (void)Register:(NSDictionary *)param WithSuccess:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    [NetWorkManager POST:@"Service.asmx/User_Reg" withParameters:param success:success failure:failure];
}

+ (void)Login:(NSDictionary *)param WithSuccess:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    [NetWorkManager POST:@"Service.asmx/User_Check" withParameters:param success:success failure:failure];
}

@end
