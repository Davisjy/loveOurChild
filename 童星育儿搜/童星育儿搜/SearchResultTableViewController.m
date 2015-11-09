//
//  SearchResultTableViewController.m
//  童星育儿搜
//
//  Created by qingyun on 15/11/8.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "AFNetworking.h"

@interface SearchResultTableViewController ()//<UISearchResultsUpdating>
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) NSString *searchStr;
@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self configSearchController];
    
    //加载数据
    [self loadData];
}

//设置searchController基本信息
- (void)configSearchController
{
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self];
    self.searchController.hidesNavigationBarDuringPresentation = YES;

    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.text = self.searchStr;
    
}

- (void)loadData
{
    
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - UISearch result updating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.searchStr = self.searchController.searchBar.text;
    
}

@end
