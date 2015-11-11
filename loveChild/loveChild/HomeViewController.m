//
//  HomeViewController.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HomeViewController.h"
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import "IATConfig.h"
#import "Account.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface HomeViewController ()<IFlyRecognizerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *originItem;

//语音识别控件
@property (nonatomic, strong) IFlyRecognizerView *iflyView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTextField];
    
    [self configIfly];
    
    if ([[Account sharedAccount] isLogin]) {
        self.navigationItem.rightBarButtonItem = nil;
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(changeVC)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else{
        self.navigationItem.rightBarButtonItem = self.originItem;
    }
}
- (IBAction)shareEveryone:(UIButton *)sender {
    [self showShareActionSheet:self.view];
}

- (void)configTextField
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"mike_small"] forState:UIControlStateNormal];
    [self.searchField rightViewRectForBounds:CGRectMake(0, 0, 30, 30)];
    btn.frame = CGRectMake(0, 0, 30, 30);
    
    self.searchField.rightView = btn;
    self.searchField.rightViewMode = UITextFieldViewModeAlways;
    
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

- (void)start
{
    [self.iflyView start];
}

- (void)changeVC
{
    UIViewController *setVC = [self.storyboard instantiateViewControllerWithIdentifier:@"set"];
    [self.navigationController pushViewController:setVC animated:YES];
}


#pragma mark 显示分享菜单

/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    //__weak HomeViewController *theController = self;
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:@[@(SSDKPlatformTypeSinaWeibo),  @(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ)]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       //                       [theController showLoadingView:NO];
                       //                       [theController.tableView reloadData];
                   }
                   
               }];
    
    //另附：设置跳过分享编辑页面，直接分享的平台。
    //        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
    //                                                                         items:nil
    //                                                                   shareParams:shareParams
    //                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
    //                                                           }];
    //
    //        //删除和添加平台示例
    //        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
}


- (void)configIfly
{
    //初始化语音识别控件
    _iflyView = [[IFlyRecognizerView alloc]initWithCenter:self.view.center];
    _iflyView.delegate = self;
    //功能领域,普通听写
    [_iflyView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    //设置返回结果为plain格式  默认是json
    [_iflyView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    IATConfig *instance = [IATConfig sharedInstance];
    //设置最长录音时间
    [_iflyView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
    //设置后端点
    [_iflyView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
    //设置前端点
    [_iflyView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
    //网络等待时间
    [_iflyView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
    
    //设置采样率，推荐使用16K
    [_iflyView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    if ([instance.language isEqualToString:[IATConfig chinese]]) {
        //设置语言
        [_iflyView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iflyView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
    }else if ([instance.language isEqualToString:[IATConfig english]]) {
        //设置语言
        [_iflyView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
    }
    //设置是否返回标点符号
    [_iflyView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(UIBarButtonItem *)sender {
    
    UIViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (IBAction)begin:(UIButton *)sender {
    [self.iflyView start];
}

- (IBAction)searchGo:(UIButton *)sender {
    UIViewController *resultVC = [self.storyboard instantiateViewControllerWithIdentifier:@"result"];
    
    [resultVC setValue:self.searchField.text forKey:@"searchNews"];
    
    [self.navigationController pushViewController:resultVC animated:YES];
    
    [self.searchField resignFirstResponder];
}

- (IBAction)didEndExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

#pragma mark - ifly delegate
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *string = [[NSMutableString alloc]init];
    NSDictionary *dic = resultArray[0];
    for (NSString *key in dic) {
        [string appendString:key];
    }
    self.searchField.text = [string copy];
    [self.iflyView cancel];
}

- (void)onError:(IFlySpeechError *)error
{
    NSLog(@"%@",error);
}

@end
