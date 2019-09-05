# 关于iPhoneX系列的适配


[iPhoneX 适配实践](https://cloud.tencent.com/community/article/322940)

[为 iPhone X 更新您的 app（官方）](https://developer.apple.com/cn/ios/update-apps-for-iphone-x/)

[architecture架构与对应的机型](https://www.innerfence.com/howto/apple-ios-devices-dates-versions-instruction-sets)

[iPhone手机尺寸对比](http://iosres.com/)

[关于UILayoutGuide、SafeAreaLayoutGuide](https://peteruncle.com/2018/01/28/NSLayoutAnchor%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/#UILayoutGuide)

----------- 


### 关于SafeArea
- iPhone X的SafeArea区域 如图
![Snip20171223_1](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905220308.png)

- 理解SafeArea

```

图中蓝色区域为安全区域

非iPhone X系列
statusBar:  20pt
navigationBar: 44pt
tabBar: 49pt ( content: (2 1; 371 48) )

iPhone X系列
statusBar:  44pt
navigationBar: 44pt
tabBar: 83pt ( 49px + 34pt )
(底部为34pt)

```

### 布局注意
```

1.子控件根据父控件来进行布局

2.如果使用Frame布局，最好在 viewDidLayoutSubView 和 layoutSubView里布局

3.所以，通常把外层的contentView做好适配的布局，然后子控件根据父控件来布局、写约束，这样以后有什么改动的话，只需要适配好外层的contentView就可以了。

（ 以下是一些常用的ContentView布局适配方案。

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
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905220728.png)

 ![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905220837.png)


### UIScrollView
```objc
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
NSLayoutConstraint *top = [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
NSLayoutConstraint *bottom = [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
NSLayoutConstraint *left = [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
NSLayoutConstraint *right = [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
[NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
}else{
    make.left.equalTo(self.view);
    make.right.equalTo(self.view);
    make.top.equalTo(self.mas_topLayoutGuideBottom);
    make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
}
}];
    
注意点：当使用自动布局来设置ScrollView需要注意约束冲突，建议嵌套一个ContentView来布局。
```

![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905220939.png)
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905221151.png)
（注意底部，当ScrollView滚动到底部的时候，会预留34pt，不会遮挡SafeArea）


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
        NSLayoutConstraint *bottom = [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        NSLayoutConstraint *left = [scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
    } else {
        make.edges.equalTo(self.view);
    }
}];
```
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905221543.png)
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905221613.png)

（同理，当TableView也是一样，滚动到底部的时候，会预留34pt，不会遮挡SafeArea）


### CollectionView 
```objc
// 1.创建
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

// 2.设置布局代理
/**
 *  cell item 的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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
 *  minimumLineSpacing 
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

/**
 *  minimumInteritemSpacing  
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

// 注意：
在布局UICollectionView时，和TableView有点不一样。需要设置Layout  UICollectionViewFlowLayoutSectionInsetFromSafeArea,这样才能让UICollectionView在横屏的时候不会遮挡safeArea。
    if (@available(iOS 11.0, *)) {
        layout.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromSafeArea;
    }

```
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905232622.png)
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905232637.png)


### SomeView & TableView 

```objc
// topView
self.topView = ({
    DDEvaluateSuccessTopView *view = [DDEvaluateSuccessTopView jz_viewFromXib];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(130.f);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
        }
    }];
    view;
});

// tableView
[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(10);
    make.right.equalTo(self.view).offset(-10);
    make.top.equalTo(self.topView.mas_bottom).offset(0);
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *bottom = [tableView.bottomAnchor constraintEqualToAnchor:weakSelf.view.bottomAnchor];
        [NSLayoutConstraint activateConstraints:@[bottom]];
    }else {
        make.bottom.equalTo(self.view);
    }
}];
```

![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905221713.png)
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905221747.png)



### safeAreaLayoutGuide
```objc
UIView *oneView = ({
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view;
});
    
if (@available(iOS 11.0, *)) {
    NSLayoutConstraint *top = [oneView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
    NSLayoutConstraint *bottom = [oneView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
    NSLayoutConstraint *left = [oneView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor];
    NSLayoutConstraint *right = [oneView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor];
    [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
    
} else {
    // Fallback on earlier versions
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
    
UIView *twoView = ({
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.purpleColor;
    [oneView addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view;
});

if (@available(iOS 11.0, *)) {
    NSLayoutConstraint *top = [oneView.topAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.topAnchor constant:-10];
    NSLayoutConstraint *bottom = [oneView.bottomAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.bottomAnchor constant:10];
    NSLayoutConstraint *left = [oneView.leftAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.leftAnchor constant:-10];
    NSLayoutConstraint *right = [oneView.rightAnchor constraintEqualToAnchor:twoView.safeAreaLayoutGuide.rightAnchor constant:10];
    [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
    
} else {
    // Fallback on earlier versions
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(oneView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

``` 

![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905222044.png)
![](https://raw.githubusercontent.com/zzzzzyijie/MyImageStore/master/blog/20190905222119.png)

