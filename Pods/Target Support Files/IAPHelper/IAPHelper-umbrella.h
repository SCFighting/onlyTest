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

#import "IAPHelper.h"
#import "IAPShare.h"
#import "NSString+Base64.h"
#import "SFHFKeychainUtils.h"

FOUNDATION_EXPORT double IAPHelperVersionNumber;
FOUNDATION_EXPORT const unsigned char IAPHelperVersionString[];

