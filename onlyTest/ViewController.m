//
//  ViewController.m
//  onlyTest
//
//  Created by SC on 2020/7/2.
//  Copyright © 2020 SC. All rights reserved.
//

#import "ViewController.h"
#import "TestController.h"
#import <SuperPlayer/SuperPlayer.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Masonry/Masonry.h>
#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelError;
#endif
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)SuperPlayerView *playerView;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self testPlayer];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"小窗" style:UIBarButtonItemStyleDone target:self action:@selector(samll)]];
//    [self testTableView];
    
}

-(void)samll
{
    SuperPlayerWindowShared.superPlayer=self.playerView;
    [SuperPlayerWindowShared show];
    [SuperPlayerWindowShared setBackHandler:^{
        [SuperPlayerWindowShared hide];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [SuperPlayerWindowShared setCloseHandler:^{
        [self.playerView pause];
    }];
    
    TestController *vc = [[TestController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)testTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.pagingEnabled = YES;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    [cell.textLabel setTextColor:UIColor.blackColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
    [cell.textLabel setText:[NSString stringWithFormat:@"我是第%ld行",(long)indexPath.row]];
    
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.textLabel setText:[NSString stringWithFormat:@"我要被展示%ld",(long)indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------------%@----------------%@-------%@-------\n",tableView,cell,cell.textLabel.text);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(![scrollView isDecelerating] && ![scrollView isDragging]){

     [self playVideo];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate){

     [self playVideo];
    }
}


-(void)playVideo
{
    for(UITableViewCell *cell in [self.tableView visibleCells])
    {
//        [self.playerView resetPlayer];
//        _playerView = nil;
//        self.playerView = [[SuperPlayerView alloc] init];
        SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
        // 设置播放地址，直播、点播都可以
        playerModel.videoURL = @"http://1255652068.vod2.myqcloud.com/3ba8fdcavodcq1255652068/238349305285890806366936403/playlist_eof.m3u8";//@"http://videobj.renrenjiang.cn/record/alilive/8161873093.m3u8";
        // 开始播放
        [self.playerView playWithModel:playerModel];
        self.playerView.fatherView = cell.contentView;
        NSLog(@"%@",cell);
    }
}


/**测试collectionView*/
-(void)testCollectionView
{
    
}

/**测试播放器*/
-(void)testPlayer
{
    self.playerView.fatherView = self.view;
    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
    // 设置播放地址，直播、点播都可以
    playerModel.videoURL =@"http://1255652068.vod2.myqcloud.com/3ba8fdcavodcq1255652068/4e7c8eb85285890809906154974/playlist_eof.m3u8";
    // 开始播放
    [self.playerView playWithModel:playerModel];
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

-(SuperPlayerView *)playerView
{
    if (_playerView == nil) {
        _playerView = [[SuperPlayerView alloc] init];
    }
    return _playerView;
}

@end
