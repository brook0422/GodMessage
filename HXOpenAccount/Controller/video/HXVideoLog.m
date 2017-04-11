//
//  HXVideoLog.m
//  OpenAccount
//
//  Created by liuchunhua on 2017/2/22.
//  Copyright © 2017年 com.shhxzq. All rights reserved.
//

#import "HXVideoLog.h"

@implementation HXVideoLog

+ (void)sendVideoLog:(HXOAVideoLogModel  *)logModel{

    return;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSDictionary *params = @{@"clientId":logModel.clientId,
//                                 @"errorType":logModel.errorType,
//                                 @"status":logModel.status,
//                                 @"wtUuid":logModel.wtUuid,
//                                 @"bizType":logModel.bizType,
//                                 @"chanel":logModel.channel,
//                                 @"flowDesc":logModel.flowDesc,
//                                 };
//        NSLog(@"sendVideoLog params = %@",params);
//        HXOAAPIType oaType = EHXOAAPITypeAddVideoLog;
//        [[HXAPIManager sharedManager] oaRequestWithAPIType:oaType parameters:params block:^(id responseObj, HXError *error) {
//            if (responseObj) {
//                
//            }else {
//                
//            }
//        }];
//    });
}
@end
