//
//  Account.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "Account.h"
#import "Common.h"

@interface Account ()<NSCoding>
@property (nonatomic, strong) NSString *userid;
@end

@implementation Account
static Account *account;
+ (instancetype)sharedAccount
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSString *filePath = [Account filePathForDocumentName:KFileName];
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if (!account) {
            account = [[Account alloc]init];
        }
    });
    return account;
}

- (void)saveUserInfo:(NSString *)string
{
    self.userid = string;
    [NSKeyedArchiver archiveRootObject:account toFile:[Account filePathForDocumentName:KFileName]];
}

- (BOOL)isLogin
{
    if (self.userid) {
        return YES;
    }
    return NO;
}

- (NSString *)currentUserId
{
    return self.userid;
}

+ (NSString *)filePathForDocumentName:(NSString *)fileName
{
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docuPath stringByAppendingPathComponent:fileName];
    return filePath;
}

#pragma mark - coding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userid = [aDecoder decodeObjectForKey:kUserID];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userid forKey:kUserID];
}

@end
