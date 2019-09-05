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

#import "AppDelegate.h"

#import <Masonry.h>

#define iOS11 @available(iOS 11.0, *)

@interface fitViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDataSource,
UICollectionViewDelegate
>

/** someView */
@property (nonatomic,strong) UIView *contentView;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;



/** insetForSection ( sction间的间距 */
@property (nonatomic,assign) UIEdgeInsets insetForSection;
/** minimumInteritemSpacing ( cell之间的间距 */
@property (nonatomic,assign) CGFloat minimumInteritemSpacing;
/** minimumLineSpacing （ 上下 行的间距 */
@property (nonatomic,assign) CGFloat minimumLineSpacing;
/** rowCount */
@property (nonatomic,assign) CGFloat rowCount;
/** itemHeight */
@property (nonatomic,assign) CGFloat itemHeight;

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
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1];
    
    CGFloat space = 15;
    self.rowCount = 3;
    self.itemHeight = 150;
    self.minimumLineSpacing = space;
    self.minimumInteritemSpacing = space;
    self.insetForSection = UIEdgeInsetsMake(space, space, 0, space);
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
//
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *someView = [UIView new];
    someView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:someView];
    
    [someView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
}

- (void)setupScrollView{
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
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
    
    // layout
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
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupContentView{
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(@available(iOS 11.0, *)){
            // Tofix: 使用masnory的这种方式 TalbeView底部会被home栏挡住
//            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            
            // 这样的话没问题
            NSLayoutConstraint *top = [tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
            NSLayoutConstraint *bottom = [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            NSLayoutConstraint *left = [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
            NSLayoutConstraint *right = [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
            [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
        }else{
            make.edges.equalTo(self.view);
        }
    }];
    
    /**
    it does't 
    if(iOS11){
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
     */
}

// CollectionView
- (void)setupCollectionView {
    
    self.collectionView = ({
        // 靠左排列的布局Layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if (@available(iOS 11.0, *)) {
            layout.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromSafeArea;
        }
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = UIColor.whiteColor;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsSelection = YES;
        collectionView.delaysContentTouches = NO;
        collectionView.alwaysBounceVertical = YES;
        collectionView.showsVerticalScrollIndicator = YES;
        collectionView.showsHorizontalScrollIndicator = YES;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self.view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(@available(iOS 11.0, *)){
                NSLayoutConstraint *top = [collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
                NSLayoutConstraint *bottom = [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
                NSLayoutConstraint *left = [collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
                NSLayoutConstraint *right = [collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
                [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
            }else{
                make.edges.equalTo(self.view);
            }
        }];
        collectionView;
    });
}

// SomeView + TableView
- (void)setupSomeViewAndTableView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *childView = ({
        UIView *childView = [[UIView alloc] init];
        childView.backgroundColor = [UIColor grayColor];
        childView;
    });
    [self.view addSubview:childView];
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(130.f);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
        }
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view).offset(0);
        make.top.equalTo(childView.mas_bottom).offset(0);
        if (iOS11) {
            NSLayoutConstraint *bottom = [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            [NSLayoutConstraint activateConstraints:@[bottom]];
        }else {
            make.bottom.equalTo(self.view);
        }
    }];
}


#pragma mark - =========================== Delegate =========================================
#pragma mark - UITableView
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
//    cell.textLabel.text = [NSString stringWithFormat:@"cell - %ldcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcell",indexPath.row];
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


#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.grayColor;
    return cell;
}

#pragma mark -- UICollectionViewLayout Delegate
/**
 *  header 头部的大小
 */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeZero;
//}

/**
 *  cell item 的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat insetW = self.insetForSection.left + self.insetForSection.right;
    CGFloat rowSpace = (self.rowCount - 1) * self.minimumInteritemSpacing;
    CGFloat contentW;
    if (@available(iOS 11.0, *)) {
        contentW = CGRectGetWidth(self.collectionView.bounds) -  self.view.safeAreaInsets.left -  self.view.safeAreaInsets.right;
    } else {
        contentW = CGRectGetWidth(self.collectionView.bounds);
    }
    CGFloat itemW = (contentW-insetW-rowSpace)/self.rowCount;
    itemW = floor(itemW); // 向下取整
    return CGSizeMake(itemW, itemW);
}

/**
 *  insetForSection
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.insetForSection;
}

/**
 *  minimumLineSpacing 在同一个section中line之间的最小间隙  ( 每一行之间的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

/**
 *  minimumInteritemSpacing 在同一行的line中item（cell）之间的最小间隙  // 设置cell之间间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

#pragma mark - =========================== Touch Event ======================================


#pragma mark - =========================== Setter/Getter ====================================

@end
