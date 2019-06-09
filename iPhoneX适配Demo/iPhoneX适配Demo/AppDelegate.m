//
//  AppDelegate.m
//  iPhoneX适配Demo
//
//  Created by Zengyijie' Com  on 2017/12/20.
//  Copyright © 2017年 www.baibu.la. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NavViewController.h"
#import "JZOtherConetentViewController.h"
#import "JZOtherTableViewController.h"
#import "JZOtherScrollViewViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 
 To fix:
    1. iOS11以下 （6sp 6p）， 有navigationBar和Tabbar的布局会占据整个屏幕（self.view），
       希望不占据整个屏幕。
    2.跳转下一个页面的时候，布局会卡顿
    3.TableView在iPhone X的适配（底部）
 */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabVc = [[UITabBarController alloc] init];
    self.tabVc = tabVc;
    NavViewController *nav = [[NavViewController alloc] initWithRootViewController:[ViewController new]];
    nav.title = @"TableView";
    
    NavViewController *nav2 = [[NavViewController alloc] initWithRootViewController:[JZOtherConetentViewController new]];
    nav2.title = @"ContentView";
    
    NavViewController *nav3 = [[NavViewController alloc] initWithRootViewController:[JZOtherScrollViewViewController new]];
    nav3.title = @"ScrollView";
    
    tabVc.viewControllers = @[nav,nav3,nav2];
    [self.window setRootViewController:tabVc];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
