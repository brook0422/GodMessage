//
//  HXOAViewController.m
//  HXOpenAccount
//
//  Created by liuchunhua on 2017/3/13.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "HXOAViewController.h"
#import "HXScanIdViewController.h"
#import "HXVideoLib.h"
#import "HXVideoViewController.h"
#import "OAQueueRspModel.h"

@interface HXOAViewController ()<UIWebViewDelegate,HXVideNotifyMessageDelegate>{
       HXOAData *_data;
}

@property (nonatomic,strong) UIWebView *oaWeb;
@property (nonatomic,strong) HXVideoLib *videoLib;
@end

@implementation HXOAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建账户";
    _data = [HXOAData getInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnUserHangUpEvent) name:@"USERHANGUPEVENT" object:nil];
    [self.view addSubview:self.oaWeb];
    [self requestWeb:self.oaWeb];
    [self onInitVideo];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *IDCardStr = [[_data dic] objectForKey:IDCardData];
    if ((IDCardStr != nil) && (IDCardStr.length > 0)){
        [self evaJS:IDCardStr];
        [_data.dic removeObjectForKey:IDCardData];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(UIWebView *)oaWeb{
    if (_oaWeb == nil){
        _oaWeb = [[UIWebView alloc] initWithFrame:self.view.frame];
        _oaWeb.delegate = self;
    }
    return _oaWeb;
}

-(void)requestWeb:(UIWebView *)webView{
    NSString *urlStr = [NSString stringWithFormat:@"%@/openAccount/UploadCard",[[IUtility testDic] objectForKey:@"ip"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *multRequst = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [multRequst addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [multRequst setHTTPMethod:@"POST"];
    NSDictionary *bankDic = [_data.dic objectForKey:BankData];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bankDic
                                                       options:nil
                                                         error:&error];
    NSString * serJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [multRequst setHTTPBody:[serJSON dataUsingEncoding:NSUTF8StringEncoding]];
    [webView loadRequest:multRequst];
}

-(void)onInitVideo{
    _videoLib = [HXVideoLib getInstance];
    _videoLib.anyChatMessageDelegate =self;
}

-(void)evaJS:(NSString *)jsFunc{
    if (self.oaWeb){
        [self.oaWeb stringByEvaluatingJavaScriptFromString:jsFunc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSString *urlStr = url.absoluteString;
    NSLog(@"url = %@",urlStr);
    if ([urlStr containsString:@"openScanIDCard"]){
        [self pushToPage:@"HXScanIdViewController"];
        //拦截不h5跳转
        return NO;
    }else if ([urlStr containsString:@"anyChatStreamIpOut"]){
        NSArray *tempArray = [urlStr componentsSeparatedByString:@"?"];
        NSMutableDictionary *anyChatDic = [[NSMutableDictionary alloc] init];
        //开始接入视频
        NSString *anyChatStr = [tempArray lastObject];
        NSArray *urlComphones = [anyChatStr componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComphones){
            NSArray *pairComponets = [keyValuePair componentsSeparatedByString:@"="];
            NSString *keyStr = [[pairComponets firstObject] stringByRemovingPercentEncoding];
            NSString *valueStr = [[pairComponets lastObject] stringByRemovingPercentEncoding];
            [anyChatDic setObject:valueStr forKey:keyStr];
        }
        OAQueueRspModel *model = [[OAQueueRspModel alloc] init];
        model.anyChatStreamIpOut = [anyChatDic objectForKey:@"anyChatStreamIpOut"];
        model.anyChatStreamPort = [anyChatDic objectForKey:@"anyChatStreamPort"];
        model.userName = [anyChatDic objectForKey:@"userName"];
        model.loginPwd = [anyChatDic objectForKey:@"loginPwd"];
        model.roomId = [anyChatDic objectForKey:@"roomId"];
        model.roomPwd = [anyChatDic objectForKey:@"roomPwd"];
        model.remoteId = [anyChatDic objectForKey:@"remoteId"];
        [_videoLib start:model];
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

#pragma mark HXVideoNotifyMessageDelegate
// 连接服务器消息
- (void) OnChatConnect:(BOOL) bSuccess{
    if (!bSuccess){
        [self evaJS:VideoFailed];
    }
}

// 当前用户登陆消息
- (void) OnChatLogin:(int) dwUserId : (int) dwErrorCode{
    if (dwErrorCode == GV_ERR_SUCCESS) {
        
    }else {
        [self evaJS:VideoFailed];
    }
}

// 当前用户进入房间消息
- (void) OnChatEnterRoom:(int) dwRoomId : (int) dwErrorCode{
    if (dwErrorCode != 0) {
        [self evaJS:VideoFailed];
    }
}

// 其他用户进入房间消息
- (void) OnChatUserEnterRoom:(int) dwUserId{
    
}

// 房间在线用户消息
- (void) OnChatOnlineUser:(int) dwUserNum : (int) dwRoomId{
    
}

// 用户退出房间消息
- (void) OnChatUserLeaveRoom:(int) dwUserId{
    [self videoDone];
    [self evaJS:VideoSuccess];
}

// 网络断开消息
- (void) OnChatLinkClose:(int) dwErrorCode{
    [self videoDone];
    [self evaJS:VideoSuccess];
}

//检测到自己与对方都已经进入成功，开始准备接入视频
- (void) OnChatPrepareVideo:(int)remoteId{
    NSLog(@"用户一跳转");
    HXVideoViewController  *_videoVC = [[HXVideoViewController alloc]init];
    _videoVC.iRemoteUserId = remoteId;
    [self.navigationController pushViewController:_videoVC animated:YES];
}

//连接anychat超时,即无回调
- (void) OnHXConnectTimeOut{
    [self videoDone];
    [self evaJS:VideoFailed];
}

#pragma mark private method
-(void)videoDone{
    for (UIViewController *subVC in self.navigationController.viewControllers){
        if ([subVC isKindOfClass:[HXVideoViewController class]]){
            [self.navigationController popViewControllerAnimated:NO];
            break;
        }
    }
}

//用户主动挂断
-(void)OnUserHangUpEvent{
    //    [self videoDone];
    [self evaJS:VideoSuccess];
}

@end
