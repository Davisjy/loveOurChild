//
//  HotSearchTableViewController.m
//  童星育儿搜
//
//  Created by qingyun on 15/11/8.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchResultTableViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchNews;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self configShow];
}

- (void)configShow
{
    self.title = @"育儿搜";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

- (void)login
{
    
}


- (IBAction)serching:(id)sender {
    UIViewController *resultvc = [self.storyboard instantiateViewControllerWithIdentifier:@"serch"];
    [resultvc setValue:self.searchNews.text forKey:@"str"];
    [self.navigationController pushViewController:resultvc animated:YES];
}





@end
