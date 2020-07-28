//
//  AppDelegate.m
//  onlyTest
//
//  Created by SC on 2020/7/2.
//  Copyright © 2020 SC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
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
    return YES;
}



@end
