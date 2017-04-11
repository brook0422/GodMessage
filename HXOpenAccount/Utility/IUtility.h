//
//  IUtility.h
//  HXOpenAccount
//
//  Created by liuchunhua on 2017/2/28.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HXIDScanModel.h"
#import <objc/runtime.h>

@interface IUtility : NSObject

//image 加密成base64
+ (NSString *)image2Base64String:(UIImage *)image;

//数据转成json
+ (NSString *)modelToJson:(HXIDScanModel *)model;

//校验身份证的数据
+ (Boolean)isSacnIdValidData:(HXIDScanModel *)model;

//将对象转换成dictionary
+ (NSDictionary *)propertyValueList:(id)object;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSDictionary *)testDic;
@end
