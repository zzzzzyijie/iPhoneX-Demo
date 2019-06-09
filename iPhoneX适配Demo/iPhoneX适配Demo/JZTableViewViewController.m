//
//  JZTableViewViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZTableViewViewController.h"

@interface JZTableViewViewController ()

@end

@implementation JZTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self _setupTableView];
}

- (void)_setupTableView{
    UITableView *tableView = [self contentTableView];
    if (!tableView) {
        return;
    }
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(@available(iOS 11.0, *)){
            // Tofix: 使用masnory的这种方式 TalbeView底部会被home栏挡住
            //            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            //            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            //            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            //            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            
            // 而使用纯代码这样却不会
            NSLayoutConstraint *top = [tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
            NSLayoutConstraint *bottom = [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            NSLayoutConstraint *left = [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
            NSLayoutConstraint *right = [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
            [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
        }else{
            make.edges.equalTo(self.view);
        }
    }];
}

- (UITableView *)contentTableView{
    if (!_contentTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView = tableView;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}



@end


