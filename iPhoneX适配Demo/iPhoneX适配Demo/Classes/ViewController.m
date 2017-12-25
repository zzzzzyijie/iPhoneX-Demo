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

#define iOS11 @available(iOS 11.0, *)

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/** titleArray */
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor clearColor];
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
    
    [self setupData];
    
    // Toobar
    //[self setupToobarView];
    
    // TableView
    [self setupTableView];
    
    // ContentView
    //[self setupContentView];
}

- (void)setupData{
    self.titleArray = @[@"SomeView",@"ToolBar",@"ContentView",@"TableView"];
    
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
}

- (void)setupToobarView{
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolbar.backgroundColor = [UIColor blueColor];
    toolbar.barTintColor = [UIColor blueColor];
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

- (void)setupTableView{
    CGRect tableViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    //tableView.backgroundColor = [UIColor orangeColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
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
    //cell.textLabel.text = [NSString stringWithFormat:@"cell - %ld",indexPath.row];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:{
            fitViewController *vc = [[fitViewController alloc] init];
            [vc addSomeView];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            fitViewController *vc = [[fitViewController alloc] init];
            [vc setupToobarView];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            fitViewController *vc = [[fitViewController alloc] init];
            [vc setupContentView];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

@end
