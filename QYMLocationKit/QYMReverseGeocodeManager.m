//
//  QYMReverseGeocodeManager.m
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import "QYMReverseGeocodeManager.h"

@implementation QYMReverseGeocodeManager

+ (void)reverseGeocodeWithLocation:(CLLocation *)location
                        comBlk:(void(^)(NSArray *array,NSError *error))comBlk{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error) {
            if (comBlk) {
            comBlk(array,error);
        }
    }];
}

@end
