//
//  HXVideoLib.h
//  HXVideoLib
//
//  Created by liuchunhua on 16/10/19.
//  Copyright © 2016年 liuchunhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnyChatDefine.h"
#import "AnyChatErrorCode.h"
#import "AnyChatObjectDefine.h"
#import "AnyChatPlatform.h"
#import "HXVideoInterface.h"
#import "OAQueueRspModel.h"
#import "HXOAVideoLogModel.h"

@interface HXVideoLib : NSObject<AnyChatNotifyMessageDelegate>

@property (nonatomic,weak)   id<HXVideNotifyMessageDelegate> anyChatMessageDelegate;
@property (nonatomic,strong) HXOAVideoLogModel *logModel;

+(HXVideoLib *)getInstance;

-(void) start:(OAQueueRspModel *)model;

-(void) stop;

@end
