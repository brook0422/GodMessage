//
//  ViewController.m
//  HXBankOA
//
//  Created by chliu.brook on 2017/1/3.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "ViewController.h"
#import <HXOpenAccount/HXOAMainViewController.h>
#import <HXOpenAccount/HXSuperVC.h>
@interface ViewController (){

}
@property (nonatomic,strong) UITextField *keyText;
@property (nonatomic,strong) UITextField *telText;
@property (nonatomic,strong) UITextField *cardNoText;
@property (nonatomic,strong) UITextField *nameText;

@property (nonatomic,strong) UITextField *ipText;
@property (nonatomic,strong) UIButton *OABtn;
@property (nonatomic,strong) UIButton *cleanBtn;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"融e生活主页";
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.keyText];
    [self.view addSubview:self.telText];
    [self.view addSubview:self.cardNoText];
    [self.view addSubview:self.nameText];
    
    [self.view addSubview:self.ipText];
    [self.view addSubview:self.OABtn];
    [self.view addSubview:self.cleanBtn];
}

-(UITextField *)keyText{
    if (_keyText == nil){
        _keyText = [[UITextField alloc]initWithFrame:CGRectMake(15, 60, 300, 30)];
        _keyText.backgroundColor = [UIColor whiteColor];
        _keyText.text = @"360200119218900";
    }
    return _keyText;
}

-(UITextField *)telText{
    if (_telText == nil){
        _telText = [[UITextField alloc]initWithFrame:CGRectMake(15, 100, 300, 30)];
        _telText.backgroundColor = [UIColor whiteColor];
        _telText.text = @"13711110000";
    }
    return _telText;
}

-(UITextField *)cardNoText{
    if (_cardNoText == nil){
        _cardNoText = [[UITextField alloc]initWithFrame:CGRectMake(15, 150, 300, 30)];
        _cardNoText.backgroundColor = [UIColor whiteColor];
        _cardNoText.text = @"450326198806181900";
    }
    return _cardNoText;
}

-(UITextField *)nameText{
    if (_nameText == nil){
        _nameText = [[UITextField alloc]initWithFrame:CGRectMake(15, 200, 300, 30)];
        _nameText.backgroundColor = [UIColor whiteColor];
        _nameText.text = @"测试1";
    }
    return _nameText;
}

-(UITextField *)ipText{
    if (_ipText == nil){
        _ipText = [[UITextField alloc]initWithFrame:CGRectMake(15, 250, 300, 30)];
        _ipText.backgroundColor = [UIColor whiteColor];
        _ipText.text = @"http://ztb-icbc-st.shhxzq.com";
    }
    return _ipText;
}


-(UIButton *)OABtn{
    if (_OABtn == nil){
        _OABtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 300, 300, 44)];
        _OABtn.backgroundColor = [UIColor whiteColor];
        [_OABtn setTitle:@"华信证券" forState:UIControlStateNormal];
        [_OABtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _OABtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_OABtn addTarget:self action:@selector(oaClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _OABtn;
}

-(UIButton *)cleanBtn{
    if (_cleanBtn == nil){
        _cleanBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 350, 300, 44)];
        _cleanBtn.backgroundColor = [UIColor whiteColor];
        [_cleanBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
        [_cleanBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cleanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cleanBtn addTarget:self action:@selector(cleanMemo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)oaClick:(UIButton *)sender {
    [self saveTestDefault];
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"HXUserInfo" ofType:@"txt"];
    NSData *UserData = [NSData dataWithContentsOfFile:pathStr];
    NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:UserData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dict);
    if ((dict != nil)
        && ![[dict objectForKey:@"clientId"] isEqualToString:@""]
        && ![[dict objectForKey:@"phoneNum"] isEqualToString:@""]
        && ![[dict objectForKey:@"idCardNum"] isEqualToString:@""]
        && ![[dict objectForKey:@"name"] isEqualToString:@""]
        && ![[dict objectForKey:@"credentialsType"] isEqualToString:@""])
    {
        [dict setObject:self.keyText.text forKey:@"clientId"];
        [dict setObject:self.telText.text forKey:@"phoneNum"];
        [dict setObject:self.cardNoText.text forKey:@"idCardNum"];
        [dict setObject:self.nameText.text forKey:@"name"];
        
        HXOAMainViewController *oaVC = [[HXOAMainViewController alloc] init];
        oaVC.hxBankInfoDict = dict;
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:oaVC animated:NO];
    }else{
        NSLog(@"参数不正常！");
    }
}

- (void)cleanMemo:(UIButton *)sender{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"清除缓存成功"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];

}

-(void)saveTestDefault{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.ipText.text forKey:@"ip"];
    [userDefaults synchronize];
}

- (void)seeHXClick:(UIButton *)sender
{
    
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

@end
