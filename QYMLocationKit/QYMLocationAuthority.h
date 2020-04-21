//
//  QYMLocationAuthority.h
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYMLocationAuthority : NSObject


/// 判断系统定位权限是否开启；YES：
+ (BOOL)locationServicesEnabled;


/// 返回用户权限
+ (CLAuthorizationStatus)locationAuthorizationStatus;


/// 判断用户授权状态，YES：已授权，NO：用户拒绝授权或未开始授权
+ (BOOL)checkLocAuthorization;

@end

NS_ASSUME_NONNULL_END
