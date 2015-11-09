//
//  Account.m
//  童星育儿搜
//
//  Created by qingyun on 15/11/8.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "Account.h"

@interface Account ()

@end

@implementation Account

static Account *account;

+ (instancetype)sharedAccount
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (account == nil) {
            account = [[Account alloc]init];
        }
    });
    return account;
}

@end
