#import "SuperPlayerControlView.h"

@implementation SuperPlayerControlView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _compact =YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (self.compact) {
        [self setOrientationPortraitConstraint];
    } else {
        [self setOrientationLandscapeConstraint];
    }
    [self.delegate controlViewDidChangeScreen:self];
}

- (void)setOrientationPortraitConstraint
{
    
}

- (void)setOrientationLandscapeConstraint
{
    
}

- (void)resetWithResolutionNames:(NSArray<NSString *> *)resolutionNames
          currentResolutionIndex:(NSUInteger)resolutionIndex
                          isLive:(BOOL)isLive
                  isTimeShifting:(BOOL)isTimeShifting
                      isPlaying:(BOOL)isAutoPlay
{
    
}

- (void)setPlayState:(BOOL)isPlay {

}

- (void)setProgressTime:(NSInteger)currentTime
              totalTime:(NSInteger)totalTime
          progressValue:(CGFloat)progress
          playableValue:(CGFloat)playable
{

}

/**
 *设置拖动时下面的进度条
 * @param currentTime 当前播放时长
 * @param totalTime   视频总时长
 * @param progress    value(0.0~1.0)
 */
- (void)setDragProgressTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime
              progressValue:(CGFloat)progress
{
    
}

@end
