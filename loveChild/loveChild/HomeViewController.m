//
//  HomeViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(UIBarButtonItem *)sender {
    UIViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)searchGo:(UIButton *)sender {
    UIViewController *resultVC = [self.storyboard instantiateViewControllerWithIdentifier:@"result"];
    
    [resultVC setValue:self.searchField.text forKey:@"searchNews"];
    
    [self presentViewController:resultVC animated:YES completion:nil];
    
    [self.searchField resignFirstResponder];
}


@end
