//
//  SQYKGESlider.m
//  shiquyun_ios
//
//  Created by pipiv5 on 2021/11/15.
//  Copyright © 2021 rayclear. All rights reserved.
//

#import "SQYKGESlider.h"

#define thumbBound_x 10
#define thumbBound_y 20

@interface SQYKGESlider ()
{
    CGRect lastBounds;
}

@end

@implementation SQYKGESlider


- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 12;
    rect.size.width = rect.size.width + 20;
    CGRect result = CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
    
    lastBounds = result;
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10) {
        if ((point.x >= lastBounds.origin.x - thumbBound_x) && (point.x <= (lastBounds.origin.x + lastBounds.size.width + thumbBound_x)) && (point.y < (lastBounds.size.height + thumbBound_y))) {
            result = YES;
        }
        
    }
    return result;
}

@end
