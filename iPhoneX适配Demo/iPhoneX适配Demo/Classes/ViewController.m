//
//  ViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2017/12/20.
//  Copyright © 2017年 www.baibu.la. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"首页";
    
    NSLog(@"viewDidLoad - self.view.info = %@",self.view);
    /*
     iOS 11 以上
         iPhoneX
            frame = (0 0; 375 812);
         iPhone8
            frame = (0 0; 375 667);
     iOS 11 以下
         iPhone7
         frame = (0 0; 375 667);
     
     */
    
    // Toobar
    //[self setupToobarView];
    
    // TableView
    //[self setupTableView];
    
    // ContentView
    [self setupContentView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews - self.view.info = %@",self.view);
    /*
     iOS 11 以上
         iPhoneX
            frame = (0 0; 375 812);
         iPhone8
            frame = (0 0; 375 667);
     iOS 11 以下
        iPhone7
        frame = (0 0; 375 667);
     
     可见 self.view 在 viewDidLoad 和 viewDidLayoutSubviews 下都是占据整个屏幕
     */
}

- (void)setupToobarView{
    
    UIView *toolbar = [[UIView alloc] initWithFrame:CGRectZero];
    toolbar.backgroundColor = [UIColor blueColor];
    [self.view addSubview:toolbar];
    
    toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *bottom = [toolbar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
        NSLayoutConstraint *height = [toolbar.heightAnchor constraintEqualToConstant:48];
        NSLayoutConstraint *left = [toolbar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [toolbar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        [NSLayoutConstraint activateConstraints:@[bottom, height, left, right]];
    }else{
        NSLayoutConstraint *bottom = [toolbar.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor];
        NSLayoutConstraint *height = [toolbar.heightAnchor constraintEqualToConstant:48];
        NSLayoutConstraint *left = [toolbar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [toolbar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        [NSLayoutConstraint activateConstraints:@[bottom, height, left, right]];
    }
}

- (void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    if (@available(iOS 11.0, *)) {
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
}

- (void)setupContentView{
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor redColor];
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
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
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
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell - %ld",indexPath.row];
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

@end
