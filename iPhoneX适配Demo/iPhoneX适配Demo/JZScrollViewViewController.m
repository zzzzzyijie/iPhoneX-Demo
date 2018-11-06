//
//  JZScrollViewViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZScrollViewViewController.h"

@interface JZScrollViewViewController ()

@end

@implementation JZScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self _setupScrollView];
}

- (void)_setupScrollView{
    
    UIScrollView *scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.alwaysBounceVertical = YES;
        scrollView;
    });
    self.contentScrollView = scrollView;
    [self.view addSubview:self.contentScrollView];

    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
}

@end
