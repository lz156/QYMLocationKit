//
//  QYMLocationModel.m
//  QYMKit
//
//  Created by Jack Luo on 2019/6/20.
//

#import "QYMLocationModel.h"
#import <objc/runtime.h>

@implementation QYMLocationModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        unsigned int count = 0;
        objc_property_t *properties  = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            
            const char *name = property_getName(properties[i]);
            NSString *key    = [NSString stringWithUTF8String:name];
            
            if (key) {
                id object = [aDecoder decodeObjectForKey:key];
                [self setValue:object forKey:key];
            }
        }
    }
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        const char *name = property_getName(properties[i]);
        NSString *key    = [NSString stringWithUTF8String:name];
        
        if (key) {
            id object = [self valueForKey:key];
            [aCoder encodeObject:object forKey:key];
        }
    }
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
