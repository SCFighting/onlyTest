//
//  UIView+wwww.m
//  onlyTest
//
//  Created by 孙超 on 2021/4/15.
//  Copyright © 2021 SC. All rights reserved.
//

#import "UIView+wwww.h"

@implementation UIView (wwww)
- (instancetype)init
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        NSLog(@"调用了%@的%s",NSStringFromClass([self class]),__FUNCTION__);
    }
    return self;
}

-(void)test
{
    NSLog(@"调用了%@的%s",NSStringFromClass([self class]),__FUNCTION__);
}

-(void)wwww
{
    NSLog(@"调用了%@的%s",NSStringFromClass([self class]),__FUNCTION__);
}
@end
