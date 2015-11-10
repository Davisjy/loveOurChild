//
//  MainViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "MainViewController.h"
#import "Account.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[Account sharedAccount] isLogin]) {
        UIViewController *saveVC = [self.storyboard instantiateViewControllerWithIdentifier:@"third"];
        [self addChildViewController:saveVC];
    }else{
        UIViewController *firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"first"];
        UIViewController *secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"second"];
        self.viewControllers = @[firstVC,secondVC];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
