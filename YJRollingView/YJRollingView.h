//
//  YJRollingView.h
//  YJRollingView
//
//  Created by yuanjianguo on 2017/8/14.
//  Copyright © 2017年 袁建国. All rights reserved.
//


//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YJRollingDirectionVerticalTop,
    YJRollingDirectionHorizonLeft,
    YJRollingDirectionVerticalBottom,
    YJRollingDirectionHorizonRight
    
} YJRollingDirection;

@interface YJRollingView : UIView

@property (nonatomic, assign)YJRollingDirection rollingDirection;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, assign)CGFloat rollingDuration;
@property (nonatomic, assign)CGFloat standbyDuration;

- (void)startRolling;
- (void)stopRolling;


@end
