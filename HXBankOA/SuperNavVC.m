//
//  SuperNavVC.m
//  ChatApp
//
//  Created by cnmobi1 on 13-9-12.
//  Copyright (c) 2013年 cnmobi1. All rights reserved.
//

#import "SuperNavVC.h"

@interface SuperNavVC ()
{
    BOOL isFristLoad;
    NSTimer *ADTimer;
    NSInteger TimerCount;
    BOOL  RequestRNFlag;
}
@end

@implementation SuperNavVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isBusy = NO;
        _isUseEnabled = YES;
        isFristLoad = YES;
        RequestRNFlag = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardStateShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardStateShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationBar setBackgroundImage:theImage forBarMetrics:UIBarMetricsDefault];
    [self.interactivePopGestureRecognizer setEnabled:YES];
    
}


-(void)HideKeyBoardFunction
{
    [self.view endEditing:YES];
}




-(void)KeyboardStateShowOrHide:(NSNotification *)Notification
{
    BOOL isShow = [[Notification name] isEqualToString:UIKeyboardWillShowNotification] ? YES : NO;
    if (isShow) {
        if (!_KeyBoardGestureRecognizer) {
            _KeyBoardGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideKeyBoardFunction)];
            [self.view addGestureRecognizer:_KeyBoardGestureRecognizer];
        }
    }
    else{
        [self.view removeGestureRecognizer:_KeyBoardGestureRecognizer];
        _KeyBoardGestureRecognizer = nil;
    }
}

#pragma mark - SuperNavVC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *VC = (UIViewController *)[self.viewControllers lastObject];
    NSString *VCStr = [NSString stringWithFormat:@"%@",VC.superclass];
    BOOL isHideTableBarVC = [VCStr isEqualToString:@"SuperHideTableBarVC"];
    if (_isBusy&&isHideTableBarVC) return;
    
    [self ViewCanUserInteractionEnabled:animated];
    [super pushViewController:viewController animated:animated];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated // Returns the popped controller.
{
    if (_isBusy)
        return nil;
    else
    {
        [self ViewCanUserInteractionEnabled:animated];
        return [super popViewControllerAnimated:animated];
    }
}


- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self ViewCanUserInteractionEnabled:animated];
    
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [self ViewCanUserInteractionEnabled:animated];
    return [super popToRootViewControllerAnimated:animated];
}


-(void)ViewCanUserInteractionEnabled:(BOOL)animated
{
    if (!_isUseEnabled || !animated) return;
    
    _isBusy = YES;

    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:0.5f];
        _isBusy = NO;
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}



@end
