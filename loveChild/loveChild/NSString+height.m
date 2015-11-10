//
//  NSString+height.m
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "NSString+height.h"

@implementation NSString (height)

- (CGSize)sizeWithFont:(UIFont *)font size:(CGSize)size
{
    CGSize resultSize;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return resultSize;
}

@end
