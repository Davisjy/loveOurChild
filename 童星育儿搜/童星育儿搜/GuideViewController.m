//
//  GuideViewController.m
//  童星育儿搜
//
//  Created by qingyun on 15/11/8.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "GuideViewController.h"
#import "Common.h"
@interface GuideViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configScrollView];
}

- (void)configScrollView
{
    
    self.scrollView.contentSize = CGSizeMake(KScrennW * KCount, KScreenH);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
}


@end
