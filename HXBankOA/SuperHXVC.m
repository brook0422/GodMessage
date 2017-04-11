//
//  SuperHXVC.m
//  HXBankOA
//
//  Created by Zhusx on 17/1/17.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "SuperHXVC.h"

@interface SuperHXVC ()

@end

@implementation SuperHXVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isBusyVC       = NO;
        _isSkidBack     = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //右滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewDidDisappear:animated];
}


#pragma mark- 返回
- (void)backFunctuion
{
    [self.view endEditing:YES];
    if (_isBusyVC) return;
    
    if (_BackVCName.length == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIViewController *BackVC = nil;
        NSArray *VCArray = self.navigationController.viewControllers;
        for (NSInteger temp = VCArray.count-1; temp >= 0; temp--) {
            if ([[VCArray objectAtIndex:temp] isKindOfClass:[NSClassFromString(_BackVCName) class]]) {
                BackVC = (UIViewController *)[VCArray objectAtIndex:temp]; break;
            }
        }
        
        if (BackVC) {
            if ([[VCArray objectAtIndex:0] isKindOfClass:[NSClassFromString(_BackVCName) class]]) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self.navigationController popToViewController:BackVC animated:YES];
            }
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


- (void)backMainFunctuion
{
    [self.view endEditing:YES];
    if (_isBusyVC) return;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
