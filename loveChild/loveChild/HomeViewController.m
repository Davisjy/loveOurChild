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
