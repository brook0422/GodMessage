//
//  HXAlertView.h
//  Test
//
//  Created by cnmobi1 on 14-4-29.
//  Copyright (c) 2014年 SZICBC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ARGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

typedef void(^AlertBtnBlock)(BOOL finished);

@interface HXAlertView : UIView
{
    CGFloat         AltViewHight;
    CGFloat         AltViewWidth;
    
    UIView          *BGView;
    UIControl       *RemoveCtl;
    
    UIView          *AlirtView;
    UILabel         *titleLabel;
    UILabel         *messageLabel;
    UIButton        *cancelButton;
    UIButton        *otherButton;
    UILabel         *line01;
    UILabel         *line02;
    
    
    BOOL            FlagShow;
}


@property(nonatomic, assign) id /*<HXAlertViewDelegate>*/ delegate;
@property(nonatomic, retain) UILabel         *messageLabel;

@property(nonatomic, copy)   AlertBtnBlock   BtnABlock;
@property(nonatomic, copy)   AlertBtnBlock   BtnBBlock;

@property(nonatomic, assign) BOOL CtlEnable;  //default is NO;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(void)show;



+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
       cancelBtnTitle:(NSString *)cancelBtnTitle
        otherBtnTitle:(NSString *)otherBtnTitle
            btnABlock:(AlertBtnBlock)btnABlock
            btnBBlock:(AlertBtnBlock)btnBBlock;

@end




@protocol HXAlertViewDelegate <NSObject>
@optional

- (void)HXAlertView:(HXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end



#pragma mark - XSZPromptView
typedef void(^PromptBlock)(BOOL finished);

@interface HXPromptView : UIView
{
    
}

@property (nonatomic, retain) UILabel   *TipLabel;

+(void)ShowPromptViewWithString:(NSString *)String andCenterPoint:(CGPoint)CenterPoint dismiss:(PromptBlock)Finished;
+(void)ShowPromptViewWithString:(NSString *)String dismiss:(PromptBlock)Finished;
+(void)ShowPromptString:(NSString *)String andCenterPoint:(CGPoint)CenterPoint;
+(void)ShowPromptString:(NSString *)String andHight:(CGFloat)Hight;
+(void)ShowPromptString:(NSString *)String andTimeInterval:(NSTimeInterval)ti;
+(void)ShowPromptString:(NSString *)String;

+(void)RemovePView;

@end


