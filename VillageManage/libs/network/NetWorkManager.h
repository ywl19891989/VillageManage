//
//  NetWorkManager.h
//  dengjibao
//
//  Created by Wenlong on 14-4-9.
//  Copyright (c) 2014年 wenlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

#define NM_PROPERTY_DECLARE(__TYPE__, __FUNC__) \
+ (void) Set##__FUNC__:(__TYPE__)var; \
+ (__TYPE__) Get##__FUNC__;

#define NM_PROPERTY_DEFINE(__TYPE__, __FUNC__) \
static __TYPE__ m_p##__FUNC__; \
+ (void) Set##__FUNC__:(__TYPE__)var { m_p##__FUNC__ = var; } \
+ (__TYPE__) Get##__FUNC__ { return m_p##__FUNC__; }

typedef void (^SuccessCallBack)(AFHTTPRequestOperation *operation, id data);
typedef void (^FailureCallBack)(AFHTTPRequestOperation *operation, NSError *error);

@interface NetWorkManager : AFHTTPRequestOperationManager

+ (NSString*)md5:(NSString*)str;

+ (void)Call:(NSString*)num;
+ (NSString*)formatWithDict:(NSDictionary*)dict;
+ (void)POST:(NSString*)path withParameters:(NSDictionary*)params success:(SuccessCallBack)success failure:(FailureCallBack)failure;

+ (void) TestProtocolWithSuccess:(SuccessCallBack)success failure:(FailureCallBack)failure;

+ (void) Login:(NSDictionary*)param WithSuccess:(SuccessCallBack)success failure:(FailureCallBack)failure;
+ (void) Register:(NSDictionary*)param WithSuccess:(SuccessCallBack)success failure:(FailureCallBack)failure;

+ (void) SetUserInfo:(NSDictionary*)info;
+ (void) InitUserInfo;

NM_PROPERTY_DECLARE(NSArray*, NewOrderList);
NM_PROPERTY_DECLARE(NSArray*, ConfirmedOrderList);
NM_PROPERTY_DECLARE(NSArray*, FinishedOrderList);
NM_PROPERTY_DECLARE(NSDictionary*, CurOrderInfo);
NM_PROPERTY_DECLARE(NSDictionary*, CurMsgInfo);

NM_PROPERTY_DECLARE(NSString*, UserId);
NM_PROPERTY_DECLARE(NSString*, UserName);
NM_PROPERTY_DECLARE(NSString*, OrderAddr);

@end
