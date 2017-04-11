//
//  HXAlertView.m
//  Test
//
//  Created by cnmobi1 on 14-4-29.
//  Copyright (c) 2014年 SZICBC. All rights reserved.
//


//  This File need  -fobjc-arc

#import "HXAlertView.h"
#define kAleMessageFont 14.0
#define kPromptTimeout  2.0


static HXPromptView *XSZ_PTView = nil;


@implementation HXAlertView
@synthesize messageLabel = messageLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        AltViewHight    = 20.0;
        AltViewWidth    = 270.0;
        FlagShow        = YES;
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(AlertViewDismissFormWindow)
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(AlertViewShowFormWindow)
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)CreateAlertViewInit
{
    AltViewHight    = 0.0;
    AltViewWidth    = 270.0;
    
    BGView = [[UIView alloc]initWithFrame:self.bounds];
    [BGView setBackgroundColor:[UIColor blackColor]];
    [BGView setAlpha:0.4];
    [self addSubview:BGView];
    
    RemoveCtl = [[UIControl alloc] initWithFrame:BGView.bounds];
    [RemoveCtl addTarget:self action:@selector(RemoveCtlFunction) forControlEvents:UIControlEventTouchUpInside];
    [BGView addSubview:RemoveCtl];
    
    AlirtView = [[UIView alloc]initWithFrame:CGRectZero];
    [AlirtView setBackgroundColor:ARGB(230, 230, 230, 1.0)];
    [AlirtView.layer setCornerRadius:12.0];
    [AlirtView.layer setBorderWidth:0.2];
    [AlirtView.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2].CGColor];
    [self addSubview:AlirtView];
    
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:18.0]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setNumberOfLines:0];
    
    
    messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [messageLabel setFont:[UIFont systemFontOfSize:kAleMessageFont]];
    [messageLabel setTextColor:[UIColor blackColor]];
    [messageLabel setTextAlignment:NSTextAlignmentCenter];
    [messageLabel setNumberOfLines:0];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTintColor:ARGB(35, 140, 235, 1.0)];
    [cancelButton setTitleColor:ARGB(35, 140, 235, 1.0) forState:UIControlStateNormal];
    [cancelButton setTitleColor:ARGB(60, 120, 250, 1.0) forState:UIControlStateHighlighted];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [cancelButton setTag:0];
    [cancelButton setBackgroundImage:theImage forState:UIControlStateHighlighted];
    AlirtView.clipsToBounds = YES;
    [cancelButton setClipsToBounds:YES];
    [cancelButton addTarget:self
                     action:@selector(TouchUpInsideFunction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    
    otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherButton setBackgroundColor:[UIColor clearColor]];
    [otherButton setTintColor:ARGB(35, 140, 235, 1.0)];
    [otherButton setTitleColor:ARGB(35, 140, 235, 1.0) forState:UIControlStateNormal];
    [otherButton setTitleColor:ARGB(60, 120, 250, 1.0) forState:UIControlStateHighlighted];
    [otherButton.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.0]];
    [otherButton setTag:1];
    [otherButton setBackgroundImage:theImage forState:UIControlStateHighlighted];
    [otherButton setClipsToBounds:YES];
    
    [otherButton addTarget:self
                    action:@selector(TouchUpInsideFunction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    
    
    line01 = [[UILabel alloc]init];
    [line01 setBackgroundColor:[UIColor grayColor]];
    [line01 setAlpha:0.6];
    
    
    line02 = [[UILabel alloc]init];
    [line02 setBackgroundColor:[UIColor grayColor]];
    [line02 setAlpha:0.6];
    
    
    [AlirtView addSubview:titleLabel];
    [AlirtView addSubview:messageLabel];
    [AlirtView addSubview:cancelButton];
    [AlirtView addSubview:otherButton];
    [AlirtView addSubview:line01];
    [AlirtView addSubview:line02];
    
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    if (self) {
        self = [self initWithFrame:[UIScreen mainScreen].bounds];
        [self setBackgroundColor:[UIColor clearColor]];
        [self CreateAlertViewInit];
        if (delegate) _delegate = delegate;
    }
    
    _CtlEnable = NO;
    
    CGFloat texthight = [self GetStringHight:title
                             andRectWithSize:CGSizeMake(AltViewWidth - 30, 300)
                                 andFontSize:18.0];
    if (title.length !=0) {
        [titleLabel setText:title];
        [titleLabel setFrame:CGRectMake(15, 10, AltViewWidth - 30, texthight)];
    }
    else
    {
        [titleLabel setFrame:CGRectMake(0, 10, 0, 0)];
    }
    AltViewHight = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    
    texthight = 30 + [self GetStringHight:message
                          andRectWithSize:CGSizeMake(AltViewWidth - 30, 300)
                              andFontSize:kAleMessageFont];
    if (message.length !=0) {
        [messageLabel setText:message];
        [messageLabel setFrame:CGRectMake(15, AltViewHight, AltViewWidth - 30, texthight)];
    }else{
        [messageLabel setFrame:CGRectMake(15, 0, AltViewWidth - 30, texthight)];
    }
    AltViewHight = AltViewHight + messageLabel.frame.size.height + 10;
    
    if (cancelButtonTitle.length !=0) {
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    else{
        [cancelButton setTitle:NSLocalizedString(@"Cancel", @"取消") forState:UIControlStateNormal];
        [cancelButton setFrame:CGRectMake(0, AltViewHight, AltViewWidth, 44)];
    }
    if (otherButtonTitles.length !=0) {
        [otherButton    setTitle:otherButtonTitles forState:UIControlStateNormal];
        [cancelButton   setFrame:CGRectMake(0, AltViewHight, AltViewWidth/2, 44)];
        [otherButton    setFrame:CGRectMake(AltViewWidth/2, AltViewHight, AltViewWidth/2, 44)];
    }
    else
    {
        [otherButton    setTitle:otherButtonTitles forState:UIControlStateNormal];
        [cancelButton   setFrame:CGRectMake(0, AltViewHight, AltViewWidth, 44)];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.0]];
        [otherButton    setFrame:CGRectMake(AltViewWidth, AltViewHight, 0, 0)];
    }
    
    
    [line01 setFrame:CGRectMake(0, AltViewHight, AltViewWidth, 0.5)];
    if (otherButtonTitles.length != 0)
        [line02 setFrame:CGRectMake(AltViewWidth/2, AltViewHight, 0.5, 44.0)];
    else
        [line02 setFrame:CGRectZero];
    
    AltViewHight = AltViewHight + cancelButton.frame.size.height;
    
    [AlirtView setFrame:CGRectMake(0, 0, AltViewWidth, AltViewHight)];
    [AlirtView setCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)];
    
    return self;
}


-(void)show
{
    UIWindow *MainWindow = [[UIApplication sharedApplication] keyWindow];
    FlagShow = YES;
    for (UIView *View in MainWindow.subviews) {
        if ([View isKindOfClass:[HXAlertView class]]) { FlagShow = NO; break;}
    }
    
    if (FlagShow) {
        [MainWindow addSubview:self];
        
        [AlirtView setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
        [AlirtView setAlpha:0.5];
        [BGView    setAlpha:0.0];
        [UIView animateWithDuration:0.3 animations:^{
            [AlirtView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            [AlirtView setAlpha:1.0];
            [BGView    setAlpha:0.4];
        }];
    }
}





-(void)TouchUpInsideFunction:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(HXAlertView:clickedButtonAtIndex:)]) {
        [_delegate HXAlertView:self clickedButtonAtIndex:button.tag];
    }
    
    if (_BtnABlock && (button.tag == 0)) {
        _BtnABlock(YES);
    }
    
    if (_BtnBBlock && (button.tag == 1)) {
        _BtnBBlock(YES);
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [AlirtView  setTransform:CGAffineTransformMakeScale(0.9, 0.9)];
        [AlirtView  setAlpha:0.0];
        [BGView     setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


-(void)setCtlEnable:(BOOL)CtlEnable
{
    _CtlEnable = CtlEnable;
    if (_CtlEnable) {
        [RemoveCtl setHidden:NO];
    }else{
        [RemoveCtl setHidden:YES];
    }
}



-(void)RemoveCtlFunction
{
    if (!_CtlEnable) return;
    
    [UIView animateWithDuration:0.2 animations:^{
        [AlirtView  setTransform:CGAffineTransformMakeScale(0.9, 0.9)];
        [AlirtView  setAlpha:0.0];
        [BGView     setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
       cancelBtnTitle:(NSString *)cancelBtnTitle
        otherBtnTitle:(NSString *)otherBtnTitle
            btnABlock:(AlertBtnBlock)btnABlock
            btnBBlock:(AlertBtnBlock)btnBBlock
{
    HXAlertView *AlertView = [[HXAlertView alloc] initWithTitle:title
                                                          message:message
                                                         delegate:nil
                                                cancelButtonTitle:cancelBtnTitle
                                                otherButtonTitles:otherBtnTitle];
    AlertView.BtnABlock = btnABlock;
    AlertView.BtnBBlock = btnBBlock;
    [AlertView show];
}




-(void)AlertViewDismissFormWindow
{
    [self setAlpha:0.0];
}


-(void)AlertViewShowFormWindow
{
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:0.5];
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setAlpha:1.0];
            [AlirtView setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
            [AlirtView setAlpha:0.5];
            [BGView     setAlpha:0.0];
            [UIView animateWithDuration:0.3 animations:^{
                [AlirtView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                [AlirtView setAlpha:1.0];
                [BGView    setAlpha:0.4];
            }];
            
        });
    });
}



-(float)GetStringHight:(NSString *)TextContent
       andRectWithSize:(CGSize)TextSize
           andFontSize:(CGFloat)FontSize
{
    float Hight = 0;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
        CGSize Size = [TextContent sizeWithFont:[UIFont boldSystemFontOfSize:FontSize] constrainedToSize:TextSize lineBreakMode:NSLineBreakByWordWrapping];
        Hight = Size.height;
    }else{
        NSDictionary *ContentDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FontSize],
                                     NSFontAttributeName,
                                     [UIColor blackColor],
                                     NSForegroundColorAttributeName,
                                     nil];
        CGRect Rect = [TextContent boundingRectWithSize:TextSize
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             attributes:ContentDict
                                                context:nil];
        Hight = Rect.size.height;
    }
    
    return Hight;
}



@end



@implementation HXPromptView

+(void)ShowPromptViewWithString:(NSString *)String
                 andCenterPoint:(CGPoint)CenterPoint
                andTimeInterval:(NSTimeInterval)ti
                        dismiss:(PromptBlock)Finished
{
    if (String.length == 0) return;
    
    //超过15个字符换弹框显示
    if (String.length >= 15) {
        HXAlertView *AlertView =[[HXAlertView alloc] initWithTitle:nil
                                                             message:String
                                                            delegate:nil
                                                   cancelButtonTitle:@"好"
                                                   otherButtonTitles:nil];
        [AlertView show];
        return;
    }
    
    
    [XSZ_PTView removeFromSuperview];
    XSZ_PTView = nil;
    @synchronized(self){
        if (XSZ_PTView  == nil) {
            XSZ_PTView = [[HXPromptView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2.0)];
        }else{return;}
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:XSZ_PTView];
    
    CGSize textSize = {250.0 ,500.0};
    UIFont *TextFont = [UIFont systemFontOfSize:14.0];
    NSDictionary *ContentDict = [NSDictionary dictionaryWithObjectsAndKeys:TextFont,
                                 NSFontAttributeName,
                                 [UIColor blackColor],
                                 NSForegroundColorAttributeName,
                                 nil];
    CGRect Rect = [String boundingRectWithSize:textSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:ContentDict
                                     context:nil];
    CGSize Size = Rect.size;
    
    CGSize CenterSize = XSZ_PTView.bounds.size;
    
    XSZ_PTView.TipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Size.width + 40, Size.height + 20)];
    [XSZ_PTView.TipLabel setClipsToBounds:YES];
    [XSZ_PTView.TipLabel.layer setCornerRadius:5.0];
    [XSZ_PTView.TipLabel setBackgroundColor:ARGB(30, 30, 30, 0.8)];
    
    [XSZ_PTView.TipLabel setNumberOfLines:0];
    [XSZ_PTView.TipLabel setTextAlignment:NSTextAlignmentCenter];
    [XSZ_PTView.TipLabel setFont:[UIFont systemFontOfSize:14.0]];
    [XSZ_PTView.TipLabel setTextColor:ARGB(250, 250, 250, 1.0)];
    
    XSZ_PTView.TipLabel.text = String;
    [XSZ_PTView addSubview:XSZ_PTView.TipLabel];
    if (CGPointEqualToPoint(CenterPoint, CGPointZero)) {
        [XSZ_PTView.TipLabel setCenter:CGPointMake(CenterSize.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0)];
    }else{
        [XSZ_PTView.TipLabel setCenter:CenterPoint];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:XSZ_PTView];
    
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:ti];
        
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (Finished) {
                Finished(YES);
            }
            [XSZ_PTView removeFromSuperview];
            XSZ_PTView = nil;
        });
    });
}



+(void)RemovePView{
    if (XSZ_PTView) {
        [XSZ_PTView removeFromSuperview];
        XSZ_PTView = nil;
    }
}

+(void)ShowPromptViewWithString:(NSString *)String andCenterPoint:(CGPoint)CenterPoint dismiss:(PromptBlock)Finished
{
    [HXPromptView ShowPromptViewWithString:String andCenterPoint:CenterPoint andTimeInterval:kPromptTimeout dismiss:Finished];
}


+(void)ShowPromptViewWithString:(NSString *)String dismiss:(PromptBlock)Finished
{
    [HXPromptView ShowPromptViewWithString:String andCenterPoint:CGPointZero andTimeInterval:kPromptTimeout dismiss:Finished];
}


+(void)ShowPromptString:(NSString *)String andCenterPoint:(CGPoint)CenterPoint
{
    [HXPromptView ShowPromptViewWithString:String andCenterPoint:CenterPoint andTimeInterval:kPromptTimeout dismiss:nil];
}


+(void)ShowPromptString:(NSString *)String andHight:(CGFloat)Hight
{
    [HXPromptView ShowPromptViewWithString:String andCenterPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, Hight) andTimeInterval:kPromptTimeout dismiss:nil];
}

+(void)ShowPromptString:(NSString *)String andTimeInterval:(NSTimeInterval)ti
{
    [HXPromptView ShowPromptViewWithString:String andCenterPoint:CGPointZero andTimeInterval:ti dismiss:nil];
}

+(void)ShowPromptString:(NSString *)String
{
    [HXPromptView ShowPromptViewWithString:String andCenterPoint:CGPointZero andTimeInterval:kPromptTimeout dismiss:nil];
}


@end


