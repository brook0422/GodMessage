//
//  HXVideoLog.h
//  OpenAccount
//
//  Created by liuchunhua on 2017/2/22.
//  Copyright © 2017年 com.shhxzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXOAVideoLogModel.h"
@interface HXVideoLog : NSObject

+ (void)sendVideoLog:(HXOAVideoLogModel  *)model;
@end
