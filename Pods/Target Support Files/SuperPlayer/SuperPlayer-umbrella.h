#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UINavigationController+SuperPlayerRotation.h"
#import "UIViewController+SuperPlayerRotation.h"
#import "AdaptiveStream.h"
#import "SPPlayCGIParseResult.h"
#import "SPSubStreamInfo.h"
#import "SPVideoFrameDescription.h"
#import "SuperPlayerSprite.h"
#import "SuperPlayerUrl.h"
#import "SPPlayCGIParser.h"
#import "SPPlayCGIParserProtocol.h"
#import "SPPlayCGIParser_V2.h"
#import "SPPlayCGIParser_V4.h"
#import "SPDefaultControlView.h"
#import "SPWeiboControlView.h"
#import "SuperPlayer.h"
#import "SuperPlayerControlView.h"
#import "SuperPlayerControlViewDelegate.h"
#import "SuperPlayerHelpers.h"
#import "SuperPlayerModel.h"
#import "SuperPlayerModelInternal.h"
#import "SuperPlayerView.h"
#import "SuperPlayerViewConfig.h"
#import "SuperPlayerWindow.h"
#import "DataReport.h"
#import "J2Obj.h"
#import "NetWatcher.h"
#import "StrUtils.h"
#import "TXCUrl.h"
#import "UIView+Fade.h"
#import "MMMaterialDesignSpinner.h"
#import "PlayerSlider.h"
#import "SuperPlayerFastView.h"
#import "SuperPlayerSettingsView.h"

FOUNDATION_EXPORT double SuperPlayerVersionNumber;
FOUNDATION_EXPORT const unsigned char SuperPlayerVersionString[];

