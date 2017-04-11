//
//  HXVideoStatusChangeInterface.h
//  OpenAccount
//
//  Created by liuchunhua on 2017/2/13.
//  Copyright © 2017年 com.shhxzq. All rights reserved.
//

@protocol HXVideoStatusChangeInterface <NSObject>

@optional
- (void)appDidBecomeActive;
- (void)appWillEnterForeground;
- (void)appWillResignActive;
- (void)appDidEnterBackground;
- (void)applicationWillTerminate;

@end
