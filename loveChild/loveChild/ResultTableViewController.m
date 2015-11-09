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

@interface ResultTableViewController ()<UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *resutl;
@property (nonatomic, strong) NSArray *msgId;

@end

@implementation ResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self configSearchController];
    
    //网络请求数据
    [self loadData];
}

- (void)configSearchController
{
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self];
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.text = self.searchNews;
}

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //构建参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"keywards"] = self.searchNews;
    parameters[@"c"] = @"iosapp";
    parameters[@"a"] = @"msglist";
    
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
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"error>>>>>%@",error);
    }];
}
- (IBAction)saveData:(UIButton *)sender {
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
    [manager GET:KUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
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
    cell.message = self.resutl[indexPath.row];
    
    return cell;
}

#pragma mark - search result updating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.searchController.searchBar.text = self.searchNews;
}

@end
