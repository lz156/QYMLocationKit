//
//  QYMLocationAuthority.h
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYMLocationAuthority : NSObject


/// 判断系统定位权限是否开启；YES：
+ (BOOL)locationServicesEnabled;


/// 返回用户权限
+ (CLAuthorizationStatus)locationAuthorizationStatus;


/// 判断用户授权状态，YES：已授权，NO：用户拒绝授权或未开始授权
+ (BOOL)checkLocAuthorization;


/// 检查权限，无权限提示alert弹框
/// - Parameter inVC: 弹框显示的控制器
+ (BOOL)checkLocAuthorizationAndShowAlertWithVC:(UIViewController *)inVC;

@end

NS_ASSUME_NONNULL_END
