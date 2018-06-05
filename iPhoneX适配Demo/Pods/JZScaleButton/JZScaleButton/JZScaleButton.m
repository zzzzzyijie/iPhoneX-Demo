//
//  JZScaleButton.m
//  MyCodeDemo
//
//  Created by 曾一桀 on 16/4/22.
//  Copyright © 2016年 JackieZeng. All rights reserved.
//

#import "JZScaleButton.h"

@interface JZScaleButton ()

@property (nonatomic,assign) BOOL isAnimation;

@end

@implementation JZScaleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (UIButtonType)buttonType{
    [self setupInit];
    return [super buttonType];
}

- (void)setupInit{
    self.isAnimation = NO;
    [self addTarget:self action:@selector(pressEvent:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
//    [self addTarget:self action:@selector(cancelEvent:) forControlEvents:];
}

- (void)pressEvent:(JZScaleButton *)button{
    [self narrowAnimation:button];
}

- (void)unpressedEvent:(JZScaleButton *)button{
    [self extendAnimation:button];
}

- (void)extendAnimation:(UIButton *)button{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        button.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
}

- (void)narrowAnimation:(UIButton *)button{
    CGFloat scale = 0.75;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        button.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:nil];
}

@end
