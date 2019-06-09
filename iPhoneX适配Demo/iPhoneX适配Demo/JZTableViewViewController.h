//
//  JZTableViewViewController.h
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZRootViewController.h"

@interface JZTableViewViewController : JZRootViewController
<
UITableViewDataSource,
UITableViewDelegate
>
/** contentTableView */
@property (nonatomic,strong) UITableView *contentTableView;
@end
