//
//  ViewController.h
//  HXBankOA
//
//  Created by chliu.brook on 2017/1/3.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@end


/*
 
 工程修改日志
 
 1.SuperNavVC 移除HXOpenAccount.a 放在工程外层
 2.资源文件 统一放在HXResourcesFile 包含ExCardSDK.framework、ExCardRes.bundle
 3.XSZAlertView 更换类名为HXAlertView
 4.SuperHXVC 更换类名HXSuperVC，同时在Build Phases 修改HXSuperVC为Public
 5.删除Bace文件夹，HXSuperVC放在video目录下
 6.IUtility.h 引入头文件 <UIKit/UIKit.h>
 
 */




