//
//  HXOAVideoLogModel.h
//  OpenAccount
//
//  Created by liuchunhua on 2017/1/16.
//  Copyright © 2017年 com.shhxzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXOAVideoLogModel : NSObject
@property(nonatomic,strong) NSString *clientId;
@property(nonatomic,strong) NSString *errorType;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *wtUuid;
@property(nonatomic,strong) NSString *bizType;
@property(nonatomic,strong) NSString *channel;
@property(nonatomic,strong) NSString *flowDesc;
@end
