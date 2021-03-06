//
//  HLCAppDelegate.m
//  HouseLoanCal
//
//  Created by 徐杨 on 15/7/21.
//  Copyright (c) 2015年 xuyang. All rights reserved.
//

#import "HLCAppDelegate.h"

//
#import "HLCMacros.h"

//
#import "HLCRootViewController.h"

//
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface HLCAppDelegate ()

@end

@implementation HLCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[HLCRootViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // 设置 statusBar 文字为亮色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 友盟统计
    [MobClick startWithAppkey:@"5602ae2de0f55ace17001418"
                 reportPolicy:BATCH
                    channelId:nil];
    // 友盟分享
    [UMSocialData setAppKey:@"5602ae2de0f55ace17001418"];
    
    // 配置微信分享
    [UMSocialWechatHandler setWXAppId:@"wxd7b7a0dbc529ac35"
                            appSecret:@"7cb6396a8d57e00a022319ebf14d95bc"
                                  url:kHLCAppStore];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = kHLCAppStore;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = kHLCAppStore;
    
    // 配置新浪微博分享
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 打开友盟统计调试模式
    [MobClick setLogEnabled:YES];
    
    return YES;
}


// 友盟回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return  [UMSocialSnsService handleOpenURL:url];
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
