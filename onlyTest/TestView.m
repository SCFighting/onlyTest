//
//  TestView.m
//  onlyTest
//
//  Created by 孙超 on 2021/4/15.
//  Copyright © 2021 SC. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"调用了%@的%s",NSStringFromClass([self class]),__FUNCTION__);
    }
    return self;
}

-(void)ttttttttttttt;
{
    NSLog(@"调用了%@的%s",NSStringFromClass([self class]),__FUNCTION__);
}

@end
