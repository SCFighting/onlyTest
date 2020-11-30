//
//  SuperPlayerWindow.m
//  TXLiteAVDemo
//
//  Created by annidyfeng on 2018/6/26.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "SuperPlayerWindow.h"
#import "SuperPlayer.h"
#import "SuperPlayerView+Private.h"
#import "UIView+MMLayout.h"
#import "DataReport.h"
#import "UIView+Fade.h"
#import "TXLiteAVSDK.h"

#define FLOAT_VIEW_WIDTH  112
#define FLOAT_VIEW_HEIGHT 200

@interface SuperPlayerWindow()<TXVodPlayListener>
@property (weak) UIView *origFatherView;
@end

@implementation SuperPlayerWindow {
    UIView *_rootView;
    UIButton    *_closeBtn;
    UIButton    *_backBtn;
}

+ (instancetype)sharedInstance {
    static SuperPlayerWindow *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SuperPlayerWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.windowLevel = UIWindowLevelStatusBar - 1;
    self.rootViewController = [UIViewController new];
    self.rootViewController.view.backgroundColor = [UIColor clearColor];
    self.rootViewController.view.userInteractionEnabled = NO;
    
    _rootView = [[UIView alloc] initWithFrame:CGRectZero];
    _rootView.backgroundColor = [UIColor blackColor];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    [_rootView addGestureRecognizer:panGesture];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:SuperPlayerImage(@"close") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:closeBtn];
    [closeBtn sizeToFit];
    _closeBtn = closeBtn;
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_rootView.mas_right).offset(-5);
        make.top.mas_equalTo(_rootView.mas_top).offset(5);
    }];
    self.hidden = YES;
    
    return self;
}


- (void)show {
    _rootView.frame = self.superPlayer.fatherView.frame;
    [self addSubview:_rootView];
    self.hidden = NO;
    
    self.origFatherView = self.superPlayer.fatherView;
    if (self.origFatherView != _rootView) {
        self.superPlayer.fatherView = _rootView;
    }
    [_rootView bringSubviewToFront:_backBtn];
    [_rootView bringSubviewToFront:_closeBtn];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        if (self.superPlayer.videoResolution.width>self.superPlayer.videoResolution.height) //横屏视频
        {
            _rootView.frame = CGRectMake(MIN(ScreenWidth, ScreenHeight)-FLOAT_VIEW_HEIGHT-10, MAX(ScreenWidth, ScreenHeight)-FLOAT_VIEW_WIDTH-100, FLOAT_VIEW_HEIGHT, FLOAT_VIEW_WIDTH);
        }
        else //竖屏视频
        {
            _rootView.frame = CGRectMake(MIN(ScreenWidth, ScreenHeight)-FLOAT_VIEW_WIDTH-10, MAX(ScreenWidth, ScreenHeight)-FLOAT_VIEW_HEIGHT-100, FLOAT_VIEW_WIDTH, FLOAT_VIEW_HEIGHT);
        }
    } completion:^(BOOL finished) {
        
    }];
    _isShowing = YES;
}

- (void)hide {    
    [_rootView removeFromSuperview];
    self.hidden = YES;
    
    self.superPlayer.fatherView = self.origFatherView;
    
    _isShowing = NO;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (CGRectContainsPoint(_rootView.bounds,
                            [_rootView convertPoint:point fromView:self])) {
        return [super pointInside:point withEvent:event];
    }
    
    return NO;
}

- (void)closeBtnClick:(id)sender
{
    if (self.closeHandler) {
        self.closeHandler();
    } else {
        [self hide];
        [_superPlayer resetPlayer];
        self.backController = nil;
    }
}

- (void)backBtnClick:(id)sender
{
    if (self.backHandler) {
        self.backHandler();
    } else {
        [self hide];
        [self.topNavigationController pushViewController:self.backController animated:YES];
        self.backController = nil;
    }
}

- (UINavigationController *)topNavigationController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController.navigationController;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self backBtnClick:nil];
}
#pragma mark - GestureRecognizer

// 手势处理
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture {
    if (UIGestureRecognizerStateBegan == panGesture.state) {
    }
    else if (UIGestureRecognizerStateChanged == panGesture.state) {
        CGPoint translation = [panGesture translationInView:self];
        
        CGPoint center = _rootView.center;
        center.x += translation.x;
        center.y += translation.y;
        _rootView.center = center;
        
        UIEdgeInsets effectiveEdgeInsets = UIEdgeInsetsZero; // 边距可以自己调
        
        CGFloat   leftMinX = 0.0f + effectiveEdgeInsets.left;
        CGFloat    topMinY = 0.0f + effectiveEdgeInsets.top;
        CGFloat  rightMaxX = self.bounds.size.width - _rootView.bounds.size.width + effectiveEdgeInsets.right;
        CGFloat bottomMaxY = self.bounds.size.height - _rootView.bounds.size.height + effectiveEdgeInsets.bottom;
        
        CGRect frame = _rootView.frame;
        frame.origin.x = frame.origin.x > rightMaxX ? rightMaxX : frame.origin.x;
        frame.origin.x = frame.origin.x < leftMinX ? leftMinX : frame.origin.x;
        frame.origin.y = frame.origin.y > bottomMaxY ? bottomMaxY : frame.origin.y;
        frame.origin.y = frame.origin.y < topMinY ? topMinY : frame.origin.y;
        _rootView.frame = frame;
        
        // zero
        [panGesture setTranslation:CGPointZero inView:self];
    }
    else if (UIGestureRecognizerStateEnded == panGesture.state) {

    }
}

/**
 * 点播事件通知
 *
 * @param player 点播对象
 * @param EvtID 参见TXLiveSDKTypeDef.h
 * @param param 参见TXLiveSDKTypeDef.h
 */
-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param
{
    
}

/**
 * 网络状态通知
 *
 * @param player 点播对象
 * @param param 参见TXLiveSDKTypeDef.h
 */
-(void) onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary*)param
{
    
}


@end
