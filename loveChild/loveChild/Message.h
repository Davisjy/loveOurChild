//
//  message.h
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSArray *images;


- (instancetype)initMessageWithDictionary:(NSDictionary *)dict;
+ (instancetype)messageWithDictionary:(NSDictionary *)dict;

@end
