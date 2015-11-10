//
//  DetailTableViewCell.h
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Message;

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *des;

+ (CGFloat)cellHeightWithMessage:(Message *)message;

@end
