//
//  YJRollingView.m
//  YJRollingView
//
//  Created by yuan on 2017/8/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "YJRollingView.h"

@interface YJRollingView ()

@property (nonatomic, strong)UIView *baseView;
@property (nonatomic, strong)UILabel *rollingLabel;
@property (nonatomic, strong)UILabel *rollingSLabel;
@property (nonatomic, strong)UIButton *tapButton;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger itemCount;

@end

@implementation YJRollingView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}


- (void)initialize
{
    self.rollingDirection = YJRollingDirectionHorizonRight;
    self.rollingDuration = 2.5f;
    self.standbyDuration = 1.5f;
    self.clipsToBounds = YES;
    [self addSubview:self.rollingLabel];
    [self addSubview:self.rollingSLabel];
    [self addSubview:self.tapButton];
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.titleArray.count == 0) {
        CGRect frame = self.frame;
        frame.size.height = 0;
        self.frame = frame;
        return;
    }
    
    self.rollingLabel.text = self.titleArray[0];
    
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
}


- (void)startRolling
{
    [self performSelector:@selector(startAni) withObject:nil afterDelay:(self.rollingDuration + self.standbyDuration)];
    
}

- (void)startAni
{
    [self.timer setFireDate:[NSDate distantPast]];
}


- (void)stopRolling
{
    [self.timer setFireDate:[NSDate distantFuture]];
}


- (void)rollingAnimation:(NSTimer *)timer
{
    if (self.titleArray.count == 0) {
        return;
    }
    switch (self.rollingDirection) {
        case YJRollingDirectionHorizonRight:
        {
            self.rollingLabel.text = self.titleArray[self.itemCount];
            NSString *nextStr = self.titleArray[(self.itemCount-1) >= 0 ? (self.itemCount-1) : (self.titleArray.count - 1)];
            self.rollingSLabel.text = nextStr;
            
            __block CGRect frameRL = self.rollingLabel.frame;
            __block CGRect frameRS = self.rollingSLabel.frame;
            frameRS.origin.x = -frameRS.size.width;
            self.rollingSLabel.frame = frameRS;
            [UIView animateWithDuration:self.rollingDuration animations:^{
                frameRL.origin.x = frameRL.size.width;
                frameRS.origin.x = 0;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
            } completion:^(BOOL finished) {
                frameRL.origin.x = 0;
                frameRS.origin.x = -frameRS.size.width;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
                self.rollingLabel.text = nextStr;
                self.itemCount ++;
                if (self.itemCount >= self.titleArray.count) {
                    self.itemCount = 0;
                }
            }];
            
        }
            break;
        case YJRollingDirectionVerticalBottom:
        {
            self.rollingLabel.text = self.titleArray[self.itemCount];
            NSString *nextStr = self.titleArray[(self.itemCount-1) >= 0 ? (self.itemCount-1) : (self.titleArray.count - 1)];
            self.rollingSLabel.text = nextStr;
            
            __block CGRect frameRL = self.rollingLabel.frame;
            __block CGRect frameRS = self.rollingSLabel.frame;
            frameRS.origin.y = -frameRS.size.height;
            self.rollingSLabel.frame = frameRS;
            [UIView animateWithDuration:self.rollingDuration animations:^{
                self.itemCount++;
                if (self.itemCount >= self.titleArray.count) {
                    self.itemCount = 0;
                }
                frameRL.origin.y = frameRL.size.height;
                frameRS.origin.y = 0;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
            } completion:^(BOOL finished) {
                frameRL.origin.y = 0;
                frameRS.origin.y = -frameRS.size.height;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
                self.rollingLabel.text = nextStr;
                
            }];
        }
            break;
        case YJRollingDirectionHorizonLeft:
        {
            self.rollingLabel.text = self.titleArray[self.itemCount];
            NSString *nextStr = self.titleArray[(self.itemCount-1) >= 0 ? (self.itemCount-1) : (self.titleArray.count - 1)];
            self.rollingSLabel.text = nextStr;
            
            __block CGRect frameRL = self.rollingLabel.frame;
            __block CGRect frameRS = self.rollingSLabel.frame;
            frameRS.origin.x = frameRS.size.width;
            self.rollingSLabel.frame = frameRS;
            [UIView animateWithDuration:self.rollingDuration animations:^{
                frameRL.origin.x = -frameRL.size.width;
                frameRS.origin.x = 0;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
            } completion:^(BOOL finished) {
                frameRL.origin.x = 0;
                frameRS.origin.x = frameRS.size.width;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
                self.rollingLabel.text = nextStr;
                self.itemCount ++;
                if (self.itemCount >= self.titleArray.count) {
                    self.itemCount = 0;
                }
            }];
        }
            break;
        case YJRollingDirectionVerticalTop:
        {
            __block CGRect frameRL = self.rollingLabel.frame;
            __block CGRect frameRS = self.rollingSLabel.frame;
            frameRS.origin.y = frameRS.size.height;
            self.rollingSLabel.frame = frameRS;
            self.rollingLabel.text = self.titleArray[self.itemCount];
            NSString *nextStr = self.titleArray[(self.itemCount-1) >= 0 ? (self.itemCount-1) : (self.titleArray.count - 1)];
            self.rollingSLabel.text = nextStr;
            
            [UIView animateWithDuration:self.rollingDuration animations:^{
                frameRL.origin.y = -frameRL.size.height;
                frameRS.origin.y = 0;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
            } completion:^(BOOL finished) {
                frameRL.origin.y = 0;
                frameRS.origin.y = -frameRS.size.height;
                self.rollingSLabel.frame = frameRS;
                self.rollingLabel.frame = frameRL;
                self.rollingLabel.text = nextStr;
                self.itemCount++;
                if (self.itemCount >= self.titleArray.count) {
                    self.itemCount = 0;
                }
            }];
        }
            break;
        default:
            break;
    }
    
    
}


- (void)onTapAction:(UIButton *)sender
{
    NSLog(@"当前点击%@",self.titleArray[self.itemCount]);
}



#pragma mark - lanjaizai

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.rollingDuration + self.standbyDuration target:self selector:@selector(rollingAnimation:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (UILabel *)rollingLabel
{
    if (!_rollingLabel) {
        _rollingLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _rollingLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _rollingLabel.textColor = [UIColor redColor];
    }
    return _rollingLabel;
}

- (UILabel *)rollingSLabel
{
    if (!_rollingSLabel) {
        _rollingSLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _rollingSLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _rollingSLabel.textColor = [UIColor redColor];
        
    }
    return _rollingSLabel;
}

- (UIButton *)tapButton
{
    if (!_tapButton) {
        _tapButton = [[UIButton alloc]initWithFrame:self.bounds];
        _tapButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_tapButton addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapButton;
}


- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}


@end
