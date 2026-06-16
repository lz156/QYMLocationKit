//
//  QYMLocationModel.m
//  QYMKit
//
//  Created by Jack Luo on 2019/6/20.
//

#import "QYMLocationModel.h"
#import <objc/runtime.h>

@implementation QYMLocationModel

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.longitude             = [aDecoder decodeDoubleForKey:@"longitude"];
        self.latitude              = [aDecoder decodeDoubleForKey:@"latitude"];
        self.country               = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"country"];
        self.administrativeArea     = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"administrativeArea"];
        self.subAdministrativeArea  = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"subAdministrativeArea"];
        self.locality               = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"locality"];
        self.subLocality            = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"subLocality"];
        self.thoroughfare           = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"thoroughfare"];
        self.subThoroughfare        = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"subThoroughfare"];
        self.areaCode               = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"areaCode"];
        self.cityCode               = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"cityCode"];
        self.date                   = [aDecoder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    }
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeDouble:self.longitude forKey:@"longitude"];
    [aCoder encodeDouble:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.administrativeArea forKey:@"administrativeArea"];
    [aCoder encodeObject:self.subAdministrativeArea forKey:@"subAdministrativeArea"];
    [aCoder encodeObject:self.locality forKey:@"locality"];
    [aCoder encodeObject:self.subLocality forKey:@"subLocality"];
    [aCoder encodeObject:self.thoroughfare forKey:@"thoroughfare"];
    [aCoder encodeObject:self.subThoroughfare forKey:@"subThoroughfare"];
    [aCoder encodeObject:self.areaCode forKey:@"areaCode"];
    [aCoder encodeObject:self.cityCode forKey:@"cityCode"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

#pragma mark - Getter
- (NSString *)getTradeCity{
    
    NSString *city = self.locality;
    if (city.length < 1) {
        city = self.subLocality;
    }
    return city;
}

- (NSString *)detailAddr{
    NSMutableString *detailAddr = [NSMutableString string];
    
    if (self.country.length > 0) {
        [detailAddr appendString:self.country];
    }
    if (self.administrativeArea.length > 0) {
        [detailAddr appendString:self.administrativeArea];
    }
    if (self.subAdministrativeArea.length > 0) {
        [detailAddr appendString:self.subAdministrativeArea];
    }
    if (self.locality.length > 0) {
        [detailAddr appendString:self.locality];
    }
    if (self.subLocality.length > 0) {
        [detailAddr appendString:self.subLocality];
    }
    if (self.thoroughfare.length > 0) {
        [detailAddr appendString:self.thoroughfare];
    }
    if (self.subThoroughfare.length > 0) {
        [detailAddr appendString:self.subThoroughfare];
    }
    return [detailAddr copy];
}

- (NSString *)formatAddr{
    
    NSMutableString *formatStr = [NSMutableString string];
    [formatStr appendFormat:@"%@&",self.administrativeArea?:@""];
    [formatStr appendFormat:@"%@&",self.locality?:self.subLocality?:@""];
    [formatStr appendFormat:@"%@&",self.subLocality?:@""];
    [formatStr appendFormat:@"%@%@",self.thoroughfare?:@"",self.subThoroughfare?:@""];
    
    return [formatStr copy];
}


@end
