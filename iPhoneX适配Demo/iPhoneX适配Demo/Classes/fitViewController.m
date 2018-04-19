//
//  fitViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2017/12/21.
//Copyright © 2017年 www.baibu.la. All rights reserved.
//

#import "fitViewController.h"
// View
#import "MyToolbar.h"
// Controller

#import "AppDelegate.h"

#import <Masonry.h>

#define iOS11 @available(iOS 11.0, *)

@interface fitViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/** someView */
@property (nonatomic,strong) UIView *contentView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;

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
    // 如果设置clearColor会渲染异常
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark - =========================== Private Method ===================================

- (void)setupContentUI{
    
}

- (void)loadRequest{
    
}

- (void)addSomeView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *someView = [UIView new];
    someView.backgroundColor = [UIColor purpleColor];
    //someView.frame = CGRectMake(0, 0,200,200);
    [self.view addSubview:someView];
    
    [someView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
}

- (void)setupScrollView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        //scrollView.contentSize = CGSizeMake(0, 1000);
        scrollView.backgroundColor = [UIColor darkGrayColor];
        scrollView.alwaysBounceVertical = YES;
        scrollView;
    });
    [self.view addSubview:scrollView];
    
    UIView *childView = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        childView;
    });
    [scrollView addSubview:childView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(scrollView.mas_left).offset(10);
        make.top.equalTo(scrollView.mas_top).offset(10);
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setupContentView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // safeArea下的 contentView
    UIView *contentView = ({
        UIView *contentView = [[UIView alloc] init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor yellowColor];
        contentView;
    });
    [self.view addSubview:contentView];
    
    UIView *childView = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor orangeColor];
        childView;
    });
    [contentView addSubview:childView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(contentView).offset(5);
        make.bottom.equalTo(contentView.mas_bottom).offset(-5);
    }];
}

- (void)setupTableView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(iOS11){
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
    
//    if(iOS11){
//        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}


#pragma mark - =========================== Delegate =========================================


#pragma mark - =========================== Touch Event ======================================


#pragma mark - =========================== Setter/Getter ====================================

@end
