//
//  HXOAData.m
//  HXOpenAccount
//
//  Created by liuchunhua on 2017/3/8.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "HXOAData.h"

@implementation HXOAData

static HXOAData *_instance;

+(HXOAData *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(id)init{
    self = [super init];
    if (self){
        _dic = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}
@end
