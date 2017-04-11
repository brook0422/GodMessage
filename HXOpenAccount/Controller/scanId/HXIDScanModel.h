//
//  HXIDScanModel.h
//  HXIDScan
//
//  Created by liuchunhua on 2017/1/9.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXIDScanModel : NSObject

@property (nonatomic, strong) NSString *name;       //姓名
@property (nonatomic, strong) NSString *gender;     //性别
@property (nonatomic, strong) NSString *nation;     //民族
@property (nonatomic, strong) NSString *birth;      //出生
@property (nonatomic, strong) NSString *address;    //地址
@property (nonatomic, strong) NSString *code;       //身份证号
@property (nonatomic, strong) NSString *codeType;   //证件类型
@property (nonatomic, strong) NSString *issue;      //签发机关
//@property (nonatomic, strong) NSString *valid;      //有效期
@property (nonatomic, strong) NSString *validStart;      //有效期
@property (nonatomic, strong) NSString *validEnd;      //有效期
@property (nonatomic, strong) NSString *frontFullImgStr;//身份证正面全图
@property (nonatomic, strong) NSString *backFullImgStr; //身份证背面全图
@end
