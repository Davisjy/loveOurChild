//
//  SaveTableViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "SaveTableViewController.h"
#import "Account.h"
#import "AFNetworking.h"
#import "Common.h"
#import "Message.h"
#import "ResultTableViewCell.h"
#import "SVProgressHUD.h"

@interface SaveTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *result;
@end

@implementation SaveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.result = [NSMutableArray array];
    [self loadData];
}


- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"c"] = @"iosapp";
    parameters[@"a"] = @"msglist";
    parameters[@"userid"] = [Account sharedAccount].currentUserId;
    
    [manager GET:KUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        NSLog(@"%@",responseObj);
        NSArray *data = responseObj[@"data"];
        for (NSDictionary *dict in data) {
            Message *message = [Message messageWithDictionary:dict];
            [self.result addObject:message];
        }
        [self.tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.result.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"save" forIndexPath:indexPath];
    cell.message = self.result[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *desVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [desVC setValue:self.result[indexPath.row] forKey:@"message"];
    [self.navigationController pushViewController:desVC animated:YES];
}


@end
