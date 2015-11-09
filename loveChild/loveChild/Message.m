//
//  message.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initMessageWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.msgId = dict[@"msgid"];
        self.title = dict[@"title"];
        self.des = dict[@"description"];
        self.images = dict[@"images"];
    }
    return self;
}

+ (instancetype)messageWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initMessageWithDictionary:dict];
}

@end
