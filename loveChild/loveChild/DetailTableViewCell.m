//
//  DetailTableViewCell.m
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "Message.h"
#import "NSString+height.h"
#import "Common.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithMessage:(Message *)message
{
    CGFloat height = 163;
    
    CGFloat textHeight = [message.des sizeWithFont:[UIFont systemFontOfSize:17] size:CGSizeMake(KScrennW, MAXFLOAT)].height;
    height += textHeight;
    
    return height;
}

@end
