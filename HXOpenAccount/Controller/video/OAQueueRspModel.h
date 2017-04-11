//
//  OAQueueRspModel.h
//  OpenAccount
//
//  Created by Liuchunhua on 16/6/23.
//  Copyright © 2016年 com.shhxzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAQueueRspModel : NSObject
@property (nonatomic,copy) NSString * errorNo;
@property (nonatomic,copy) NSString * errorInfo;
@property (nonatomic,copy) NSString * waitPosition;
@property (nonatomic,copy) NSString * waitPositionInSelfOrg;
@property (nonatomic,copy) NSString * waitNum;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * anyChatStreamIpOut;
@property (nonatomic,copy) NSString * anyChatStreamPort;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * loginPwd;
@property (nonatomic,copy) NSString * roomId;
@property (nonatomic,copy) NSString * roomPwd;
@property (nonatomic,copy) NSString * remoteId;
@end
