
# iPhoneX/XS/XR/MAX的适配相关


[iPhoneX 适配实践](https://cloud.tencent.com/community/article/322940)
[为 iPhone X 更新您的 app（官方）](https://developer.apple.com/cn/ios/update-apps-for-iphone-x/)
[理解SafeArea](https://www.jianshu.com/p/63c0b6cc66fd)
[architecture架构与对应的机型](https://www.innerfence.com/howto/apple-ios-devices-dates-versions-instruction-sets)
[iPhone手机尺寸对比](http://iosres.com/)

----------- 


### 关于SafeArea
- iPhone X的SafeArea区域 如图
![Snip20171223_1](media/15139144670024/Snip20171223_1.png)

- 理解SafeArea

```

图中蓝色区域为安全区域



非iPhone X系列
statusBar:  20pt
navigationBar: 44pt
tabBar: 49pt ( content: (2 1; 371 48)

iPhone X系列
statusBar:  44pt
navigationBar: 44pt
tabBar: 83pt ( 49px + 34pt )
(底部为34pt)


```


### 布局注意
```

1.子控件根据父控件来进行布局

2.如果使用frame，最好在 viewDidLayoutSubView 和 layoutSubView里布局

个人认为做好container的布局，然后子控件依赖父控件布局即可。
```



### ContentView
- 在iPhone X中ContentView的布局

```objc
    // safeArea下的 contentView
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor yellowColor];
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

```

### UIScrollView
```

        UIScrollView *scrollView = ({
            UIScrollView *scrollView = [[UIScrollView alloc] init];
            //scrollView.contentSize = CGSizeMake(0, 1000);
            scrollView.backgroundColor = SupplierAppBGColor;
            scrollView.alwaysBounceVertical = YES;
            scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            scrollView;
        });
        _scrollView = scrollView;
        [self.view addSubview:scrollView];
        
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
        
```


### TableView

- 在iPhone X中TableView的布局

```objc
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableView.backgroundColor = [UIColor orangeColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            NSLayoutConstraint *top = [tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
            NSLayoutConstraint *bottom = [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            NSLayoutConstraint *left = [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
            NSLayoutConstraint *right = [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
            [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
        } else {
            make.edges.equalTo(self.view);
        }
    }];
    
    // TableView这个还需要待修改，因为在masnory布局中这样是不对的，但运行却没问题。

```




