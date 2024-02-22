//
//  AppDelegate.m
//  onlyTest
//
//  Created by SC on 2020/7/2.
//  Copyright © 2020 SC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <TXLiteAVSDK_Professional/TXLiteAVSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *mainVC = [[ViewController alloc] init];
    UINavigationController *NAV = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = NAV;
    [self.window makeKeyAndVisible];
    [TXLiveBase setLicenceURL:@"http://license.vod2.myqcloud.com/license/v1/d0698495c5236d29fbc812ebf466cf6e/TXLiveSDK.licence" key:@"cf04240c93a2717f855b1d632f3022a7"];
    [TXUGCBase setLicenceURL:@"http://license.vod2.myqcloud.com/license/v1/d0698495c5236d29fbc812ebf466cf6e/TXUgcSDK.licence" key:@"cf04240c93a2717f855b1d632f3022a7"];
    return YES;
}



@end
