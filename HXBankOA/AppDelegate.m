//
//  AppDelegate.m
//  HXBankOA
//
//  Created by chliu.brook on 2017/1/3.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SuperNavVC.h"
#import <HXOpenAccount/HXVideoLifeCycle.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *rootVC = [[ViewController alloc] init];
    SuperNavVC *nav = [[SuperNavVC alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = nav;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[HXVideoLifeCycle sharedManager] appWillResignActive];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[HXVideoLifeCycle sharedManager] appDidEnterBackground];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[HXVideoLifeCycle sharedManager] appWillEnterForeground];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[HXVideoLifeCycle sharedManager] appDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
