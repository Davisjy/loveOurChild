//
//  ResultTableViewCell.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "ResultTableViewCell.h"
#import "Message.h"
#import "UIImageView+WebCache.h"

@implementation ResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(Message *)message
{
    _message = message;
    self.title.text = message.title;
    self.text.text = message.des;
    NSURL *url = [NSURL URLWithString:message.middleImageStr];
    [self.icon sd_setImageWithURL:url];
}

@end
