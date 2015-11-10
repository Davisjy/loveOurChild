//
//  HotSearchViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HotSearchViewController.h"
#import "AFNetworking.h"
#import "Common.h"
#import "HotSearch.h"
#import "HotCollectionViewCell.h"
#import "SVProgressHUD.h"


@interface HotSearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *labelId;
@property (weak, nonatomic) IBOutlet UICollectionView *collctionView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation HotSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [NSMutableArray array];
    
    [self loadData];
    [self configCollectionAndTextField];
    
    //加载效果
    [SVProgressHUD show];
}

- (void)configCollectionAndTextField
{
    self.collctionView.delegate = self;
    self.collctionView.dataSource = self;
    self.collctionView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"mike_small"] forState:UIControlStateNormal];
    [self.textField rightViewRectForBounds:CGRectMake(0, 0, 30, 30)];
    btn.frame = CGRectMake(0, 0, 30, 30);
    
    self.textField.rightView = btn;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
}

- (IBAction)go:(UIButton *)sender {
    
    UIViewController *desVC = [self.storyboard instantiateViewControllerWithIdentifier:@"result"];
    [desVC setValue:self.textField.text forKey:@"searchNews"];
    [self.navigationController pushViewController:desVC animated:YES];
}

- (IBAction)didEndExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"c"] = @"iosapp";
    parameters[@"a"] = @"labels";
    [manager GET:KUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        
        NSArray *datas = responseObj[@"data"];
        for (NSDictionary *dict in datas) {
            HotSearch *model = [HotSearch hotSearchWithDictionary:dict];
            [self.data addObject:model];
        }
        [self.collctionView reloadData];
        [SVProgressHUD dismiss];
        //NSLog(@"%@",self.data);
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - collection view delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hot" forIndexPath:indexPath];
    HotSearch *hot = self.data[indexPath.row] ;
    cell.labelName.text = hot.labelName;
    
    CGFloat red = round(random()%256)/256 ;
    CGFloat green = round(random()%256)/256;
    CGFloat blue = round(random()%256)/256;
    
    cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    cell.layer.cornerRadius = 40;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *desVC = [self.storyboard instantiateViewControllerWithIdentifier:@"result"];
    HotSearch *hot = self.data[indexPath.row];
    NSString *searchStr = hot.labelName;
    [desVC setValue:searchStr forKey:@"searchNews"];
    [self.navigationController pushViewController:desVC animated:YES];
}

@end
