//
//  OpenHXItemVC.m
//  HXBankOA
//
//  Created by Zhusx on 17/1/17.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "OpenHXItemVC.h"
#import "XSZAlertView.h"

@interface OpenHXItemVC ()

@end

@implementation OpenHXItemVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"HXUserInfo" ofType:@"txt"];
        NSData *UserData = [NSData dataWithContentsOfFile:pathStr];
        
        _HXMoreDict = [NSJSONSerialization JSONObjectWithData:UserData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"_HXMoreDict = %@",_HXMoreDict);
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden:YES];
    
    
    UIButton *AButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AButton setFrame:CGRectMake(20, 60, self.view.frame.size.width - 40, 40)];
    [AButton setTitle:@"下一视图" forState:UIControlStateNormal];
    [AButton setBackgroundColor:[UIColor blueColor]];
    [AButton addTarget:self action:@selector(AButtonFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AButton];
    
    
    UIButton *BButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [BButton setFrame:CGRectMake(20, 120, self.view.frame.size.width - 40, 40)];
    [BButton setTitle:@"返回按钮" forState:UIControlStateNormal];
    [BButton setBackgroundColor:[UIColor blueColor]];
    [BButton addTarget:self action:@selector(BButtonFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BButton];
    
    
    
    UIButton *CButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CButton setFrame:CGRectMake(20, 180, self.view.frame.size.width - 40, 40)];
    [CButton setTitle:@"返回根视图" forState:UIControlStateNormal];
    [CButton setBackgroundColor:[UIColor blueColor]];
    [CButton addTarget:self action:@selector(CButtonFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CButton];
    

    UIButton *DButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DButton setFrame:CGRectMake(20, 240, self.view.frame.size.width - 40, 40)];
    [DButton setTitle:@"弹框测试A" forState:UIControlStateNormal];
    [DButton setBackgroundColor:[UIColor blueColor]];
    [DButton addTarget:self action:@selector(DButtonFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:DButton];
    
    
    UIButton *EButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [EButton setFrame:CGRectMake(20, 300, self.view.frame.size.width - 40, 40)];
    [EButton setTitle:@"弹框测试B" forState:UIControlStateNormal];
    [EButton setBackgroundColor:[UIColor blueColor]];
    [EButton addTarget:self action:@selector(EButtonFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:EButton];

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

-(void)AButtonFunction
{
    OpenHXItemVC *ItemVC = [[OpenHXItemVC alloc] init];
    [self.navigationController pushViewController:ItemVC animated:YES];
}



-(void)BButtonFunction
{
    [self backFunctuion];
}


-(void)CButtonFunction
{
    [self backMainFunctuion];
}


-(void)DButtonFunction
{
    XSZAlertView *AlertView = [[XSZAlertView alloc] initWithTitle:@""
                                                          message:@"Test ABC"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"好"];
    [AlertView show];
}


-(void)EButtonFunction
{
    [XSZPromptView ShowPromptViewWithString:@"你好这是一个小测试"
                                    dismiss:^(BOOL finished) {
                                        NSLog(@"请在这里操作你的代码");
    }];
}

@end
