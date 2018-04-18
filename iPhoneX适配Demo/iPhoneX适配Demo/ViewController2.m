//
//  ViewController2.m
//  iPhoneX适配Demo
//
//  Created by noone on 2018/4/17.
//  noone
//


#import "ViewController2.h"
// View

// Controller
#import <Masonry.h>

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInit];
    
    [self setupContentUI];
    
    [self loadRequest];
}

#pragma mark - =========================== Inial Method ====================================
- (void)setupInit{
    self.navigationItem.title = @"ContentView";
}

#pragma mark - =========================== Private Method ===================================

- (void)setupContentUI{
    
    // safeArea下的 contentView
    UIView *contentView = ({
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor yellowColor];
        contentView;
    });
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
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
        }
    }];
}

- (void)loadRequest{
    
}

#pragma mark - =========================== Delegate =========================================


#pragma mark - =========================== Touch Event ======================================


#pragma mark - =========================== Setter/Getter ====================================

@end
