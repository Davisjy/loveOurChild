//
//  HotSearch.h
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotSearch : NSObject

@property (nonatomic, strong) NSString *labelId;
@property (nonatomic, strong) NSString *labelName;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)hotSearchWithDictionary:(NSDictionary *)dict;

@end
