//
//  LocationManager.h
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class CLLocation;

typedef void (^LocationResultBlock)(BOOL success,
                                    NSArray * _Nullable locations,
                                    NSError * _Nullable error);

@interface QYMLocationManager : NSObject


/// 开始定位
/// @param resultBlock 结果回调
- (void)startLocationWithResutlBlock:(LocationResultBlock)resultBlock;

/// 开始定位，传入manager
/// @param manager <#manager description#>
/// @param resultBlock <#resultBlock description#>
- (void)startLocationWithManager:(CLLocationManager *)manager block:(LocationResultBlock)resultBlock;


/// 取消定位
- (void)cancelLocation;

@end

NS_ASSUME_NONNULL_END
