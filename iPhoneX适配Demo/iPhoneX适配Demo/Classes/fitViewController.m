//
//  fitViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2017/12/21.
//Copyright © 2017年 www.baibu.la. All rights reserved.
//

#import "fitViewController.h"
// View

// Controller

#import <Masonry.h>

#define iOS11 @available(iOS 11.0, *)

@interface fitViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation fitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInit];
    
    [self setupContentUI];
    
    [self loadRequest];
}

#pragma mark - =========================== Inial Method ====================================
- (void)setupInit{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - =========================== Private Method ===================================

- (void)setupContentUI{
    
}

- (void)loadRequest{
    
}

- (void)addSomeView{
    UIView *someView = [UIView new];
    someView.backgroundColor = [UIColor purpleColor];
    //someView.frame = CGRectMake(0, 0,200,200);
    [self.view addSubview:someView];
    
    [someView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
}

- (void)setupToobarView{
    
    UIView *toolbar = [[UIView alloc] initWithFrame:CGRectZero];
    toolbar.backgroundColor = [UIColor blueColor];
    //toolbar.barTintColor = [UIColor blueColor];
    [self.view addSubview:toolbar];
    
    toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (iOS11) {
        [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(48);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }];
    }else{
        [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(48);
            make.left.right.bottom.equalTo(self.view);
        }];
    }
    
}

- (void)setupContentView{
    // safeArea下的 contentView
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor yellowColor];
    //v.frame = CGRectMake(0, 64,self.view.frame.size.width,self.view.frame.size.height-64);
    //v.frame = CGRectMake(0, 88,self.view.frame.size.width,self.view.frame.size.height-88);
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.top.equalTo(self.mas_bottomLayoutGuideTop);
            make.bottom.equalTo(self.mas_topLayoutGuideBottom);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
        }
    }];
}

- (void)setupTableView{

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableView.backgroundColor = [UIColor orangeColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            NSLayoutConstraint *top = [tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
            NSLayoutConstraint *bottom = [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            NSLayoutConstraint *left = [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
            NSLayoutConstraint *right = [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
            [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
        } else {
            NSLayoutConstraint *top = [tableView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
            NSLayoutConstraint *bottom = [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            NSLayoutConstraint *left = [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
            NSLayoutConstraint *right = [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
            [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //cell.backgroundColor = [UIColor orangeColor];
        cell.contentView.backgroundColor = [UIColor orangeColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell - %ld",indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


#pragma mark - =========================== Delegate =========================================


#pragma mark - =========================== Touch Event ======================================


#pragma mark - =========================== Setter/Getter ====================================

@end
