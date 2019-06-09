//
//  JZScrollViewViewController.h
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2018/11/6.
//  Copyright © 2018年 www.baibu.la. All rights reserved.
//

#import "JZRootViewController.h"

@interface JZScrollViewViewController : JZRootViewController
<
UIScrollViewDelegate
>
/** contentScrollView */
@property (nonatomic,strong) UIScrollView *contentScrollView;
@end
