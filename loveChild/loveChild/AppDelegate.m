//
//  AppDelegate.m
//  loveChild
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "AppDelegate.h"
#import <iflyMSC/IFlySpeechUtility.h>
#import "Common.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    self.window.rootViewController = [self instanceRootViewController];
    [self.window makeKeyAndVisible];
    
    //讯飞语音基本注册
    NSString *initStr = [NSString stringWithFormat:@"appid=%@",@"5565df39"];
    [IFlySpeechUtility createUtility:initStr];
    
    //分享基本注册
    [self shareSDKResign];
    
    return YES;
}

- (id)instanceRootViewController
{
    NSString *currentVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *locolVersion = [defaults objectForKey:KApp_Version];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([currentVersion isEqualToString:locolVersion]) {
        
        UIViewController *mainVC = [sb instantiateViewControllerWithIdentifier:@"main"];
        return mainVC;
    }else{
        UIViewController *guideVC = [sb instantiateViewControllerWithIdentifier:@"guide"];
        return guideVC;
    }
}

- (void)endGuide
{
    NSString *currentVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentVersion forKey:KApp_Version];
    [defaults synchronize];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainVC = [sb instantiateViewControllerWithIdentifier:@"main"];
    self.window.rootViewController = mainVC;
}

- (void)shareSDKResign
{
    //设置shareSDK的appkey
    [ShareSDK registerApp:@"iosv1101"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),  @(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeWechat:
                      [ShareSDKConnector connectWeChat:[WXApi class]];
                      break;
                  case SSDKPlatformTypeQQ:
                      [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                      break;
                  case SSDKPlatformTypeSinaWeibo:
                      [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                      break;
                  default:
                      break;
              }
              
          }
     
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeBoth];
                      break;
                      
                  default:
                      break;
              };
          }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
