//
//  HXIDScanModel.m
//  HXIDScan
//
//  Created by liuchunhua on 2017/1/9.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "HXIDScanModel.h"

@implementation HXIDScanModel

-(id)init{
    self = [super init];
    if (self){
        _name            = @"";
        _gender          = @"";
        _nation          = @"";
        _birth           = @"";
        _address         = @"";
        _code            = @"";
        _codeType        = @"00";
        _issue           = @"";
//        _valid           = @"";
        _validStart      = @"";
        _validEnd        = @"";
        _frontFullImgStr = @"";
        _backFullImgStr  = @"";
    }
    return self;
}
@end
