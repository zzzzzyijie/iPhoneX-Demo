//
//  JZOtherScrollViewViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZOtherScrollViewViewController.h"
#import <Masonry.h>

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
//    self.view.backgroundColor = [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1];
}

- (void)setupContentUI{
    
    UIScrollView *scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.contentSize = CGSizeMake(0, 1000);
        scrollView.backgroundColor = UIColor.whiteColor;
        scrollView.alwaysBounceVertical = YES;
        scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        scrollView;
    });
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            NSLayoutConstraint *bottom = [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            [NSLayoutConstraint activateConstraints:@[bottom]];
        }else{
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    
    // ContentView in SrcollView
    UIView *containerView = ({
        UIView *view = [[UIView alloc] init];
        [scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.width.equalTo(scrollView);
            make.height.greaterThanOrEqualTo(@0.f);
        }];
        view;
    });
    
    
    // child view one
    UIView *childView = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        childView;
    });
    [containerView addSubview:childView];
    
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.top.equalTo(scrollView).offset(10);
        make.leading.equalTo(scrollView).offset(10);
    }];
    
    
    // child view two
    UIView *childView2 = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        //childView.frame = CGRectMake(0, 951, UIScreen.mainScreen.bounds.size.width, 49);
        childView;
    });
    [containerView addSubview:childView2];
    [childView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(49);
        make.top.equalTo(childView.mas_bottom).offset(951);
        make.leading.trailing.equalTo(containerView).offset(0);
        // this is important
        make.bottom.equalTo(containerView).offset(-5);
    }];
}

@end
