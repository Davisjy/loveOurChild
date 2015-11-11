//
//  GuideViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = self.contentView.frame.size;
}

- (IBAction)endGuide:(UIButton *)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate endGuide];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
