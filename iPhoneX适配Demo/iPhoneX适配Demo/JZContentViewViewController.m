//
//  JZContentViewViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZContentViewViewController.h"

@interface JZContentViewViewController ()

@end

@implementation JZContentViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupContentView];
}

- (void)_setupContentView{
    
    // safeArea下的 contentView
    UIView *contentView = ({
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView;
    });
    self.contentView = contentView;
    [self.view addSubview:self.contentView];
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
