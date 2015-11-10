//
//  HotSearch.m
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HotSearch.h"

@implementation HotSearch

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.labelId = dict[@"labelid"];
        self.labelName = dict[@"labelname"];
    }
    return self;
}

+ (instancetype)hotSearchWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}

@end
