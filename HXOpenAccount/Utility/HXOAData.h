//
//  HXOAData.h
//  HXOpenAccount
//
//  Created by liuchunhua on 2017/3/8.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXOAData : NSObject

@property (nonatomic,strong) NSMutableDictionary *dic;

+(HXOAData *)getInstance;

@end
