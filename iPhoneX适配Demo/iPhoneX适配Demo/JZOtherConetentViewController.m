//
//  JZOtherConetentViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZOtherConetentViewController.h"

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
    self.view.backgroundColor = [UIColor whiteColor];
    //self.contentView.backgroundColor = [UIColor purpleColor];
}

- (void)setupContentUI{
    
    UIView *childView = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        childView;
    });
    [self.contentView addSubview:childView];

    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(self.contentView).offset(5);
       // make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
    }];
}

@end
