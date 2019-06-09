//
//  JZOtherScrollViewViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZOtherScrollViewViewController.h"

@interface JZOtherScrollViewViewController ()

@end

@implementation JZOtherScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupInit];
    
    [self setupContentUI];
}


- (void)setupInit{
    self.navigationItem.title = @"contentScrollView";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupContentUI{
    
    UIView *childView = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        childView;
    });
    [self.contentScrollView addSubview:childView];
    
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(self.contentScrollView.mas_left).offset(10);
        make.top.equalTo(self.contentScrollView.mas_top).offset(10);
    }];
}

@end
