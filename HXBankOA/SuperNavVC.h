//
//  SuperNavVC.h
//  ChatApp
//
//  Created by cnmobi1 on 13-9-12.
//  Copyright (c) 2013年 cnmobi1. All rights reserved.
//
/*
 1:基于导航栏的跟基类，SuperHideTableBarVC和SuperShowTableBarVC都是继承这个类
 */
#import <UIKit/UIKit.h>


typedef void(^SuperNavADBlock)(BOOL finished);

@interface SuperNavVC : UINavigationController

@property (nonatomic, assign) BOOL isUseEnabled;
@property (nonatomic, assign) BOOL isBusy;


@property (nonatomic, retain) UIActivityIndicatorView *IndicatorView;

@property (nonatomic, retain) UITapGestureRecognizer *KeyBoardGestureRecognizer;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;


@end
