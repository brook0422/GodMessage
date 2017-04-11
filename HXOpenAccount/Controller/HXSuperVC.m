//
//  HXSuperVC.m
//  HXBankOA
//
//  Created by Zhusx on 17/1/17.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "HXSuperVC.h"

@interface HXSuperVC ()

@end

@implementation HXSuperVC

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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:nil action:@selector(backMainFunctuion)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
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
    if (_isBusyVC)
        return;
    
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
    if (_isBusyVC)
        return;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)pushToPage:(NSString *)page{
    UIViewController *tempVC = [[NSClassFromString(page) alloc] init];
    [self.navigationController pushViewController:tempVC animated:NO];
}
@end
