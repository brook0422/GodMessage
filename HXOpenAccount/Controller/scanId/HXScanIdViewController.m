//
//  HXScanIdViewController.m
//  HXIDScan
//
//  Created by liuchunhua on 2017/1/8.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "HXScanIdViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <ExCardSDK/ExCardSDK.h>
#import "HXIDScanModel.h"
#import "HXOAMainViewController.h"

#define FRONT_TAG   0x1033
#define BACK_TAG    0x1034

#define BTNHEIGHT 44.0f
#define OFFSETHEIGHT 10.0f
#define OFFSETWIDTH 5.0f
#define BOARDWIDTH 0.5f

@interface HXScanIdViewController (){
    float imgHeight;
    float topY;
    HXIDScanModel *_scanModel;
}

@property (nonatomic, strong) EXOCRIDCardInfo * IDInfo;
@property (nonatomic, strong) UIImageView *frontFullImageView;
@property (nonatomic, strong) UIImageView *backFullImageView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UILabel *hintLabel;
@end

@implementation HXScanIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [EXOCRCardEngineManager initEngine];
    self.title = @"身份证扫描";
    [self initUI];
    _scanModel = [[HXIDScanModel alloc]init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)initUI{
    topY = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    imgHeight = (self.view.frame.size.height - topY - 30 - BTNHEIGHT - OFFSETWIDTH - OFFSETHEIGHT * 3)/2.0;
    [self.view addSubview:self.hintLabel];
    [self.view addSubview:self.frontFullImageView];
    [self.view addSubview:self.backFullImageView];
    [self.view addSubview:self.nextButton];
}

-(UILabel *)hintLabel{
    if (_hintLabel == nil){
        _hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(OFFSETWIDTH, 0, self.view.frame.size.width, 30)];
        _hintLabel.textColor = [UIColor whiteColor];
        _hintLabel.backgroundColor = [UIColor blackColor];
        _hintLabel.text = @"请保持照片清晰完整，避免反光";
        _hintLabel.font = [UIFont boldSystemFontOfSize:16.0];
    }
    return _hintLabel;
}
-(UIImageView *)frontFullImageView{
    if (_frontFullImageView == nil){
        _frontFullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(OFFSETWIDTH, self.hintLabel.frame.size.height + OFFSETWIDTH, self.view.frame.size.width - OFFSETWIDTH * 2, imgHeight)];
//        [_frontFullImageView setImage:[UIImage imageNamed:@"scanid_add_btn.png"]];
        _frontFullImageView.layer.borderWidth = BOARDWIDTH;
        _frontFullImageView.userInteractionEnabled = YES;
        _frontFullImageView.tag = FRONT_TAG;
    }
    return _frontFullImageView;
}

-(UIImageView *)backFullImageView{
    if (_backFullImageView == nil){
        _backFullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frontFullImageView.frame.origin.x, self.frontFullImageView.frame.origin.y + self.frontFullImageView.frame.size.height + OFFSETHEIGHT, self.frontFullImageView.frame.size.width, imgHeight)];
//        [_backFullImageView setImage:[UIImage imageNamed:@"scanid_add_btn.png"]];
        _backFullImageView.layer.borderWidth = BOARDWIDTH;
        _backFullImageView.userInteractionEnabled = YES;
        _backFullImageView.tag = BACK_TAG;
    }
    return _backFullImageView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == _frontFullImageView){
        [self launchCameraView:_frontFullImageView];
    }else if ([touch view] == _backFullImageView){
        [self launchCameraView:_backFullImageView];
    }else {
        
    }
}

-(UIButton *)nextButton{
    if (_nextButton == nil){
        _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frontFullImageView.frame.origin.x, self.backFullImageView.frame.origin.y + self.backFullImageView.frame.size.height + OFFSETHEIGHT, self.view.frame.size.width - OFFSETWIDTH*2, BTNHEIGHT)];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:[UIColor blueColor]];
        [_nextButton addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.layer.borderWidth = BOARDWIDTH;
        [_nextButton setBackgroundImage:[IUtility imageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
        [_nextButton setBackgroundImage:[IUtility imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        [_nextButton setEnabled:NO];
    }
    return _nextButton;
}

-(void)nextBtnClick:(UIButton *)btn{
    if (![IUtility isSacnIdValidData:_scanModel]){
        [HXAlertView showWithTitle:@"提示" message:@"身份证信息有误" cancelBtnTitle:nil otherBtnTitle:@"确定" btnABlock:nil btnBBlock:nil];
        return;
    }
    NSString *modelStr = [IUtility modelToJson:_scanModel];
    modelStr = [NSString stringWithFormat:@"window.bank.successCallback(%@)",modelStr];
    HXOAData *_data = [HXOAData getInstance];
    [_data.dic setObject:modelStr forKey:IDCardData];
    
    UIViewController *tempVC = [[NSClassFromString(@"HXOAMainViewController") alloc] init];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)launchCameraView:(UIImageView *)sender
{
    BOOL bShouldFront = YES;
    if (sender.tag == FRONT_TAG) {
        bShouldFront = YES;
    } else {
        bShouldFront = NO;
    }
    EXOCRIDCardRecoManager *manager = [EXOCRIDCardRecoManager sharedManager:self];
    [manager setImageMode:ID_IMAGEMODE_HIGH];
    
    __weak typeof(self) weakSelf = self;
    [manager recoIDCardFromStreamWithSide:bShouldFront OnCompleted:^(int statusCode, EXOCRIDCardInfo *idInfo) {
        NSLog(@"Completed");
        NSLog(@"%@", [idInfo toString]);
        weakSelf.IDInfo = idInfo;
        [weakSelf loadData];
    } OnCanceled:^(int statusCode) {
        NSLog(@"Canceled");
    } OnFailed:^(int statusCode, UIImage *recoImg) {
        NSLog(@"Failed");
        [self updateScanIdImg:bShouldFront];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"识别失败，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

-(void)updateScanIdImg:(BOOL)isFront{
    if (isFront){
        _scanModel.frontFullImgStr = @"";
    }else{
        _scanModel.backFullImgStr = @"";
    }
}

-(void)loadData
{
    if (_IDInfo.type == 1) {
        //人脸
        if (_IDInfo.frontFullImg != nil) {
            [self.frontFullImageView setImage:_IDInfo.frontFullImg];
        }
        _scanModel.name = _IDInfo.name;
        _scanModel.gender = _IDInfo.gender;
        _scanModel.nation = _IDInfo.nation;
        _scanModel.birth = _IDInfo.birth;
        _scanModel.address = _IDInfo.address;
        _scanModel.code = _IDInfo.code;
        _scanModel.frontFullImgStr = [IUtility image2Base64String:_IDInfo.frontFullImg];

    }else{
        if (_IDInfo.backFullImg != nil){
            [self.backFullImageView setImage:_IDInfo.backFullImg];
        }
        _scanModel.issue = _IDInfo.issue;
        NSArray *validArray = [_IDInfo.valid componentsSeparatedByString:@"-"];
        if (validArray.count == 2){
            _scanModel.validStart = [validArray firstObject];
            _scanModel.validEnd = [validArray lastObject];
        }else {
            _scanModel.validStart = _IDInfo.valid;
            _scanModel.validEnd = _IDInfo.valid;
        }
        _scanModel.backFullImgStr = [IUtility image2Base64String:_IDInfo.backFullImg];
    }
    if (![IUtility isSacnIdValidData:_scanModel]){
        [_nextButton setEnabled:NO];
    }else{
        [_nextButton setEnabled:YES];
    }
}

-(void)dealloc{
    [EXOCRCardEngineManager finishEngine];
}

@end
