//
//  JZOtherConetentViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZOtherConetentViewController.h"
#import <Masonry.h>

@interface JZOtherConetentViewController ()

@end

@implementation JZOtherConetentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInit];
    
    [self setupContentUI];
}


- (void)setupInit{
    self.navigationItem.title = @"OtherConetentView";
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)setupContentUI{
    
    // safeArea下的 contentView
    UIView *contentView = [UIView new];
    contentView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
            make.leading.trailing.equalTo(self.view);
        }
    }];
    
    
    UIView *childView = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        childView;
    });
    [contentView addSubview:childView];
    
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(contentView).offset(5);
        make.top.equalTo(contentView).offset(5);
       // make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    
    UIView *childView2 = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        childView.frame = CGRectMake(0, 951, UIScreen.mainScreen.bounds.size.width, 49);
        childView;
    });
    [contentView addSubview:childView2];
    [childView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(49);
        make.bottom.leading.trailing.equalTo(contentView).offset(0);
    }];
}

@end
