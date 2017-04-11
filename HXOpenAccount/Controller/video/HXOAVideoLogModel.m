//
//  HXOAVideoLogModel.m
//  OpenAccount
//
//  Created by liuchunhua on 2017/1/16.
//  Copyright © 2017年 com.shhxzq. All rights reserved.
//

#import "HXOAVideoLogModel.h"

@implementation HXOAVideoLogModel

-(id)init{
    self = [super init];
    if (self){
        _clientId = @"";
        _errorType = @"";
        _status = @"";
        _wtUuid = @"";
        _bizType = @"";
        _channel = @"";
        _flowDesc = @"";
    }
    return self;
}
@end
