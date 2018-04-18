//
//  NavViewController.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/4/14.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}


@end
