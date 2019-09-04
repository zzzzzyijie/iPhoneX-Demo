//
//  LayoutMarginViewController.m
//  iPhoneX适配Demo
//
//  Created by Jie on 2019/9/4.
//  Copyright © 2019 www.baibu.la. All rights reserved.
//

#import "LayoutMarginViewController.h"
#import <Masonry.h>

@interface LayoutMarginViewController ()

@end

@implementation LayoutMarginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self officalDemo];
//    return;
    
    UIView *oneView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.yellowColor;
        [self.view addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view;
    });
    
//    self.view.safeAreaLayoutGuide.topAnchor
    
    if (@available(iOS 11.0, *)) {
//        NSLayoutConstraint *top = [oneView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
//        NSLayoutConstraint *bottom = [oneView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
//        NSLayoutConstraint *left = [oneView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor];
//        NSLayoutConstraint *right = [oneView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor];
//        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
        [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }];
    } else {
        // Fallback on earlier versions
        [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    UIView *twoView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.purpleColor;
        [oneView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view;
    });

    if (@available(iOS 11.0, *)) {
//        NSLayoutConstraint *top = [oneView.topAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.topAnchor constant:-10];
//        NSLayoutConstraint *bottom = [oneView.bottomAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.bottomAnchor constant:10];
//        NSLayoutConstraint *left = [oneView.leftAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.leftAnchor constant:-10];
//        NSLayoutConstraint *right = [oneView.rightAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.rightAnchor constant:10];
//        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
        
        [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }];
    } else {
        // Fallback on earlier versions
        [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(oneView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }

}

- (void)officalDemo {
    // Creating constraints using NSLayoutConstraint
    UIView *subview = [UIView new];
    subview.backgroundColor = UIColor.grayColor;
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subview];
    
    [NSLayoutConstraint constraintWithItem:subview
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0
                                  constant:0.0
     ].active = YES;
    
    [NSLayoutConstraint constraintWithItem:subview
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0
                                  constant:0.0
     ].active = YES;
    
    // Creating the same constraints using Layout Anchors
    UILayoutGuide *margin = self.view.layoutMarginsGuide;
    [subview.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    [subview.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = YES;
}

@end
