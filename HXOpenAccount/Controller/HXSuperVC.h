//
//  HXSuperVC.h
//  HXBankOA
//
//  Created by Zhusx on 17/1/17.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSuperVC : UIViewController<UIGestureRecognizerDelegate>
{
    BOOL            _isBusyVC;          //当前视图控制器是否繁忙，默认NO
}
@property (nonatomic, retain)   NSString            *BackVCName;            //需要返回的VC类名
@property (nonatomic, assign)       BOOL            isSkidBack;             //是否侧滑返回

//返回函数
- (void)backFunctuion;
- (void)backMainFunctuion;
//跳转函数
- (void)pushToPage:(NSString *)page;

@end
