//
//  HXOAMainViewController.m
//  HXOpenAccount
//
//  Created by liuchunhua on 2017/1/8.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "HXOAMainViewController.h"

@interface HXOAMainViewController ()<UIWebViewDelegate>{
    HXOAData *_data;

}
@property (nonatomic,strong) UIWebView *oaMainWeb;
@end

@implementation HXOAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"华信证券";
    [self.view addSubview:self.oaMainWeb];
    _data = [HXOAData getInstance];
    [_data.dic setObject:_hxBankInfoDict forKey:BankData];
    [self requestWeb:self.oaMainWeb];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(UIWebView *)oaMainWeb{
    if (_oaMainWeb == nil){
        _oaMainWeb = [[UIWebView alloc] initWithFrame:self.view.frame];
        _oaMainWeb.delegate = self;
    }
    return _oaMainWeb;
}

-(void)requestWeb:(UIWebView *)webView{
    NSString *urlStr = [NSString stringWithFormat:@"%@/icbc",[[IUtility testDic] objectForKey:@"ip"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *multRequst = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [multRequst addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [multRequst setHTTPMethod:@"POST"];
    NSString *bankClientId = [_hxBankInfoDict objectForKey:@"clientId"];
    if (bankClientId == nil  || [bankClientId isEqualToString:@""]){
        return;
    }
    NSDictionary *params = @{@"clientId":bankClientId};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                        options:nil
                                                            error:&error];
    NSString * serJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [multRequst setHTTPBody:[serJSON dataUsingEncoding:NSUTF8StringEncoding]];
    [webView loadRequest:[multRequst copy]];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSString *urlStr = url.absoluteString;
    NSLog(@"url = %@",urlStr);
    if ([urlStr containsString:@"uploadCardInfo"]){
        [self pushToPage:@"HXOAViewController"];
        //拦截不h5跳转
        return NO;
    }else if ([urlStr containsString:@"icbciphone/tool"]) {
        [self backMainFunctuion];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
