//
//  QYMReverseGeocodeManager.h
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYMReverseGeocodeManager : NSObject


/// 解析地理编码编码
/// @param location <#location description#>
/// @param comBlk <#comBlk description#>
+ (void)reverseGeocodeWithLocation:(CLLocation *)location
                            comBlk:(void(^)(NSArray *array,NSError *error))comBlk;

@end

NS_ASSUME_NONNULL_END
