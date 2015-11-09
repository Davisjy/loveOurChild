//
//  Account.h
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

+ (instancetype)sharedAccount;

- (void)saveUserInfo:(NSDictionary *)dict;

- (BOOL)isLogin;

- (NSString *)currentUserId;

@end
