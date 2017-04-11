//
//  OpenHXItemVC.h
//  HXBankOA
//
//  Created by Zhusx on 17/1/17.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "SuperHXVC.h"

@interface OpenHXItemVC : SuperHXVC

@property (nonatomic, retain) NSDictionary  *HXMoreDict;

@end

/*
 注意要点：
 1.键盘释放，在app进入后台时，要监听键盘是否释放
 2.[self presentViewController:nextVC animated:NO completion:nil]; 尽量不要使用，如果有使用的VC，请把对应的VC类名提供清单
 
 3.传输数据类型
 
 NSDictionary  *HXMoreDict;
 
 bankList =     (                   //持续卡银行卡列表 ，值可能为nil
 {
 cardno = 6222084000000991391;
 },
 {
 cardno = 6222084000000991391;
 }
 );
 clientId = 360200119218971;        //客户唯一编号
 credentialsType = 0;               //证件类型
 idCardNum = 450326198806181956;    //证件ID
 name = "\U8205\U9e9f\U8f89";       //用户姓名
 phoneNum = 18838889999;            //用户手机号码
 
 
 */
