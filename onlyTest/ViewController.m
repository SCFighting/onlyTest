//
//  ViewController.m
//  onlyTest
//
//  Created by SC on 2020/7/2.
//  Copyright © 2020 SC. All rights reserved.
//

#import "ViewController.h"
#import <SuperPlayer/SuperPlayer.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelError;
#endif
@interface ViewController ()
@property(nonatomic,strong)SuperPlayerView *playerView;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

/**测试collectionView*/
-(void)testCollectionView
{
    
}

/**测试播放器*/
-(void)testPlayer
{
    _playerView = [[SuperPlayerView alloc] init];
        // 设置代理，用于接受事件
    //    _playerView.delegate = self;
        // 设置父 View，_playerView 会被自动添加到 holderView 下面
        _playerView.fatherView = self.view;

        SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
        // 设置播放地址，直播、点播都可以
        playerModel.videoURL = @"http://200024424.vod.myqcloud.com/200024424_709ae516bdf811e6ad39991f76a4df69.f20.mp4";
        // 开始播放
        [_playerView playWithModel:playerModel];
}

/**测试调试log*/
-(void)testDDlog
{
    if (@available(iOS 10.0, *)) {
        [DDLog addLogger:[DDOSLogger sharedInstance]];
    } else {
        // Fallback on earlier versions
    } // Uses os_log

    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];


    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
}

@end
