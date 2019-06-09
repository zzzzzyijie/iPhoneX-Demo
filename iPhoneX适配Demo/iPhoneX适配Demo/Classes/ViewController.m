//
//  ViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2017/12/20.
//  Copyright © 2017年 www.baibu.la. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "fitViewController.h"
//#import <JZScaleButton.h>
#import "JZOtherConetentViewController.h"
#import "JZOtherScrollViewViewController.h"
#import "JZOtherTableViewController.h"

#define iOS11 @available(iOS 11.0, *)

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/** titleArray */
@property (nonatomic,strong) NSArray *titleArray;
/** contentTableView */
@property (nonatomic,strong) UITableView *contentTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = @"iPhoneX-适配";
    
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
    
    [self setupData];
    
    // Toobar
    //[self setupToobarView];
    
    // TableView
    [self setupTableView];
    
    // ContentView
    //[self setupContentView];
}

- (void)setupData{
    self.titleArray = @[@"scrollView",@"ContentView",@"TableView",@"ToolBar"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = YES;
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
    //self.contentTableView.frame = self.view.bounds;
}

- (void)setupTableView{
    UITableView *contentTableView = ({
        UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:contentTableView];
        contentTableView.showsVerticalScrollIndicator = NO;
        contentTableView.showsHorizontalScrollIndicator = NO;
        contentTableView.alwaysBounceVertical = YES;
        contentTableView.backgroundColor = [UIColor whiteColor];
        contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        contentTableView.delegate = self;
        contentTableView.dataSource = self;
        contentTableView.rowHeight = 70;
        contentTableView;
    });
    self.contentTableView = contentTableView;
    [contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(iOS11){
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.edges.equalTo(self.view);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //cell.backgroundColor = [UIColor orangeColor];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:{
            JZOtherScrollViewViewController *vc = [[JZOtherScrollViewViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            JZOtherConetentViewController *vc = [[JZOtherConetentViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            JZOtherTableViewController *vc = [[JZOtherTableViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            fitViewController *vc = [[fitViewController alloc] init];
            [vc setupTableView];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

@end
