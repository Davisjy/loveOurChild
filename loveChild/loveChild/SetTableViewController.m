//
//  SetTableViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "SetTableViewController.h"
#import "Account.h"

@interface SetTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *data;

@end

@implementation SetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"切换账号",@"退出登录"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UIViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else if (indexPath.section == 1){
        //存一个空userId即退出登录
        [[Account sharedAccount]saveUserInfo:nil];
        UIViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
        [self presentViewController:mainVC animated:YES completion:nil];
    }
}


@end
