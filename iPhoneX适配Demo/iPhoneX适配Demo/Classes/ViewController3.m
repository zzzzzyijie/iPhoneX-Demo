//
//  ViewController3.m
//  iPhoneX适配Demo
//
//  Created by noone on 2018/4/18.
//  noone
//


#import "ViewController3.h"
#import <Masonry.h>
// View

// Controller

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInit];
    
    [self setupContentUI];
    
    [self loadRequest];
}

#pragma mark - =========================== Inial Method ====================================
- (void)setupInit{
    self.navigationItem.title = @"ScrollView";
}

#pragma mark - =========================== Private Method ===================================

- (void)setupContentUI{
    
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

- (void)loadRequest{
    
}

#pragma mark - =========================== Delegate =========================================


#pragma mark - =========================== Touch Event ======================================


#pragma mark - =========================== Setter/Getter ====================================

@end
