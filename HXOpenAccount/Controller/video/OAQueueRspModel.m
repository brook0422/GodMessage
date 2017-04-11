//
//  OAQueueRspModel.m
//  OpenAccount
//
//  Created by Liuchunhua on 16/6/23.
//  Copyright © 2016年 com.shhxzq. All rights reserved.
//

#import "OAQueueRspModel.h"

@implementation OAQueueRspModel
-(id)init
{
    self = [super init];
    if (self) {
        _waitPosition = @"";
        _waitPositionInSelfOrg = @"";
        _waitNum = @"";
        _status = @"";
        _anyChatStreamIpOut = @"";
        _anyChatStreamPort = @"";
        _userName = @"";
        _loginPwd = @"";
        _roomId = @"";
        _roomPwd = @"";
        _remoteId = @"";
        _errorNo = @"";
        _errorInfo = @"";
    }
    
    return self;
}
@end
