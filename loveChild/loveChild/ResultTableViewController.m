//
//  ResultTableViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "ResultTableViewController.h"
#import "ResultTableViewCell.h"
#import "AFNetworking.h"
#import "Common.h"
#import "Message.h"
#import "Account.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface ResultTableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *resutl;
@property (nonatomic, strong) NSArray *msgId;
//用于page参数
@property (nonatomic) int page;

@end

@implementation ResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置基本searchController
    [self configSearchController];
    
    [SVProgressHUD show];
    //网络请求数据
    [self loadData];
    
    //默认是第一页
    self.page = 1;
}

- (void)configSearchController
{
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.text = self.searchNews;
}

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //构建参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"keywards"] = self.searchNews;
    parameters[@"c"] = @"iosapp";
    parameters[@"a"] = @"msglist";
    parameters[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [manager GET:KUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        NSLog(@"%@",responseObj);
        
        NSArray *data = responseObj[@"data"];
        NSMutableArray *datas = [NSMutableArray array];
        NSMutableArray *msgIds = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            Message *message = [Message messageWithDictionary:dict];
            [datas addObject:message];
            [msgIds addObject:message.msgId];
        }
        self.resutl = datas;
        self.msgId = msgIds;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"error>>>>>%@",error);
    }];
}
- (IBAction)saveData:(UIButton *)sender {
    
    if (![[Account sharedAccount]isLogin]) {
        UIViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    UIView *contentView = sender.superview;
    UITableViewCell *currentCell = (UITableViewCell *)contentView.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:currentCell];
    NSString *msgid = self.msgId[indexPath.row];
    NSString *username = [[Account sharedAccount] currentUserId];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"msgid"] = msgid;
    parameters[@"userid"] = username;
    parameters[@"c"] = @"iosapp";
    parameters[@"a"] = @"collect";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:KUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        //NSLog(@"%@",responseObj);
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void)loadMore
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //构建参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"keywards"] = self.searchNews;
    parameters[@"c"] = @"iosapp";
    parameters[@"a"] = @"msglist";
    parameters[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [manager GET:KUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        NSLog(@"%@",responseObj);
        NSArray *data = responseObj[@"data"];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            Message *message = [Message messageWithDictionary:dict];
            [models addObject:message];
        }
        self.resutl = [self.resutl arrayByAddingObjectsFromArray:models];
        [self.tableView reloadData];
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resutl.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    
    if (self.resutl.count == indexPath.row + 1) {
        self.page ++;
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [self loadMore];
            //mj的上拉刷新
            [tableView.footer endRefreshing];
        }];
    }
    
    cell.message = self.resutl[indexPath.row];
    
    return cell;
}

#pragma mark - table view delegate
#if 0
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *desVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [desVC setValue:self.resutl[indexPath.row] forKey:@"message"];
    [self.navigationController pushViewController:desVC animated:YES];
}
#endif

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *desVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [desVC setValue:self.resutl[indexPath.row] forKey:@"message"];
    [self.navigationController pushViewController:desVC animated:YES];
    return indexPath;
}

#pragma mark - search result updating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.searchNews = self.searchController.searchBar.text;
    if ([self.searchController.searchBar.text isEqualToString:@""]) {
    }else{
        [self loadData];
    }
}

@end
