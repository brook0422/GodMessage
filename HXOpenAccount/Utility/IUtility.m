//
//  IUtility.m
//  HXOpenAccount
//
//  Created by liuchunhua on 2017/2/28.
//  Copyright © 2017年 chliu.brook. All rights reserved.
//

#import "IUtility.h"

@implementation IUtility

+ (NSString *)image2Base64String:(UIImage *)image {
    if (!image) {
        return @"";
    }
    
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    //Compress the image
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    
    imageData = UIImageJPEGRepresentation(image, compression);
    
    while ([imageData length] > MAX_UPLOAD_SIZE && compression > maxCompression) {
        compression -= 0.10;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return [imageData base64EncodedStringWithOptions:0];
}

+ (NSString *)modelToJson:(HXIDScanModel *)model{
    NSDictionary *dic = @{@"name":model.name,
                          @"sex":model.gender,
                          @"nation":model.nation,
                          @"birthday":model.birth,
                          @"address":model.address,
                          @"idCardNo":model.code,
                          @"codeType":model.codeType,
                          @"issuingAuthority":model.issue,
                          @"validStartDate":model.validStart,
                          @"validEndDate":model.validEnd,
                          @"idCardPic":model.frontFullImgStr,
                          @"idCardBackPic":model.backFullImgStr,
                          };
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (Boolean)isSacnIdValidData:(HXIDScanModel *)model{
    Boolean result = true;
    NSDictionary *modelDic = [IUtility propertyValueList:model];
    for (NSString *value in [modelDic allValues]){
        if ((value == nil) || ([value isEqualToString:@""])){
            result = false;
            break;
        }
    }
    return result;
}

+ (NSDictionary *)propertyValueList:(id)object
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [object valueForKey:(NSString *)propertyName];
        if (propertyValue)
            [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (NSDictionary *)testDic{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *ip = [userDefault objectForKey:@"ip"];
    return @{@"ip":ip,
             };
}
@end
