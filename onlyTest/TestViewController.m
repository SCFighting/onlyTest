//
//  TestViewController.m
//  onlyTest
//
//  Created by SC on 2023/11/4.
//  Copyright © 2023 SC. All rights reserved.
//

#import "TestViewController.h"
#import <ConnectSDK/ConnectSDK.h>

@interface TestViewController ()<DevicePickerDelegate, ConnectableDeviceDelegate>

@end

@implementation TestViewController
{
    DiscoveryManager *_discoveryManager;
        ConnectableDevice *_device;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _discoveryManager = [DiscoveryManager sharedManager];
       [_discoveryManager startDiscovery];
    _discoveryManager.devicePicker.delegate = self;
       [_discoveryManager.devicePicker showPicker:nil];
   
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan: touches withEvent:event];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];

}

- (void)devicePicker:(DevicePicker *)picker didSelectDevice:(ConnectableDevice *)device
{
    _device = device;
    _device.delegate = self;
    [_device connect];
}

- (void)connectableDeviceConnectionSuccess:(ConnectableDevice *)device forService:(DeviceService *)service
{
        NSURL *mediaURL = [NSURL URLWithString:@"http://qcloudvod.renrenjiang.cn/3ba8fdcavodcq1255652068/0017e2ff3270835011485720837/playlist_eof.m3u8"]; // credit: Blender Foundation/CC By 3.0
        NSURL *iconURL = [NSURL URLWithString:@"http://www.connectsdk.com/files/7313/9657/0225/test_video_icon.jpg"]; // credit: sintel-durian.deviantart.com
        NSString *title = @"Sintel Trailer";
        NSString *description = @"Blender Open Movie Project";
        NSString *mimeType = @""; // audio/* for audio files

        MediaInfo *mediaInfo = [[MediaInfo alloc] initWithURL:mediaURL mimeType:mimeType];
        mediaInfo.title = title;
        mediaInfo.description = description;
        ImageInfo *imageInfo = [[ImageInfo alloc] initWithURL:iconURL type:ImageTypeThumb];
        [mediaInfo addImage:imageInfo];

        if ([_device hasCapability:kMediaPlayerSubtitleWebVTT]) {
            NSURL *subtitlesURL = [NSURL URLWithString:@"http://ec2-54-201-108-205.us-west-2.compute.amazonaws.com/samples/media/sintel_en.vtt"];
            SubtitleInfo *subtitleInfo = [SubtitleInfo infoWithURL:subtitlesURL
                                                          andBlock:^(SubtitleInfoBuilder *builder) {
                                                              builder.mimeType = @"text/vtt";
                                                              builder.language = @"English";
                                                              builder.label = @"English Subtitles";
                                                          }];
            mediaInfo.subtitleInfo = subtitleInfo;
        }

        __block MediaLaunchObject *launchObject;

        [_device.mediaPlayer playMediaWithMediaInfo:mediaInfo
                                             shouldLoop:NO
                                                success:
         ^(MediaLaunchObject *mediaLaunchObject) {
             NSLog(@"play video success");

             // save the object reference to control media playback
             launchObject = mediaLaunchObject;

             // enable your media control UI elements here
         }
                                                failure:
         ^(NSError *error) {
             NSLog(@"play video failure: %@", error.localizedDescription);
         }];
    
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
