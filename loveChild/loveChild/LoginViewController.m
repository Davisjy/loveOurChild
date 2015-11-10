//
//  LoginViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "Common.h"
#import "Account.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defatult = [NSUserDefaults standardUserDefaults];
    NSString *name = [defatult objectForKey:@"name"];
    self.username.text = name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)login:(UIButton *)sender {
    NSString *username = self.username.text;
    NSString *pwd = self.password.text;
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:username forKey:@"name"];
    [defults synchronize];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = username;
    parameters[@"pwd"] = pwd;
    parameters[@"c"] = @"iosapp";
    parameters[@"a"] = @"login";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:KUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        NSLog(@"%@",responseObj);
        int code = [responseObj[@"code"] intValue];
        NSDictionary *data = responseObj[@"data"];
        if (code == 0) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"用户名或密码错误" message:@"请输入正确信息" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.password.text = @"";
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        if (code == 1) {
            Account *accout = [Account sharedAccount];
            [accout saveUserInfo:data[kUserID]];
            if ([[Account sharedAccount]isLogin]) {
                UIViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
                [self presentViewController:mainVC animated:YES completion:nil];
            }
            
        }
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}
- (IBAction)didEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
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
