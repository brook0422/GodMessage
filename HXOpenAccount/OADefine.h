//
//  OADefine.h
//  HXOpenAccount
//
//  Created by liuchunhua on 2017/2/28.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#ifndef OADefine_h
#define OADefine_h

#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define MAX_UPLOAD_SIZE 100 * 1024

#define IDCardData  @"IDCardData" //身份证扫描出来的数据
#define BankData    @"BankData"   //银行传入的数据

#define VideoSuccess  @"window.securVideoCall.successCallback()"
#define VideoFailed   @"window.securVideoCall.failCallback()"

#endif /* OADefine_h */
