//
//  QYMLocationAuthority.m
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import "QYMLocationAuthority.h"

@implementation QYMLocationAuthority

+ (BOOL)locationServicesEnabled{
    return [CLLocationManager locationServicesEnabled];
}

+ (CLAuthorizationStatus)locationAuthorizationStatus{
    
    return [CLLocationManager authorizationStatus];
}

+ (BOOL)checkLocAuthorization{
    
    CLAuthorizationStatus status = [self locationAuthorizationStatus];
    if ([self locationServicesEnabled] &&
        (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
         status == kCLAuthorizationStatusAuthorizedAlways)) {
        
        return YES;
    }
    else{
        return NO;
    }
}


+ (BOOL)checkLocAuthorizationAndShowAlert{
    
    if ([self checkLocAuthorization]) {
        return YES;
    }
    else{
        if (![self locationServicesEnabled]) {
            [self showAlertWithTitle:@"打开定位开关"
                             message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)"];
        }
        else if([self locationAuthorizationStatus] == kCLAuthorizationStatusNotDetermined){
            
        }
        else{
            NSString *appName = [self appBundleDisplayName];
            NSString *msg = [NSString stringWithFormat:@"请在系统设置中开启定位服务(设置>隐私>定位服务>%@>使用应用期间)",appName];
            [self showAlertWithTitle:@"打开定位服务权限" message:msg];
        }
    }
    
    return NO;
}

#pragma mark - App显示名称
+ (NSString *)appBundleDisplayName{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

#pragma mark -
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        [self openAppSettings];
    }]];
    
    UIViewController *vc = nil;
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] > 0) {
        UIWindow *window = windows[0];
        vc = window.rootViewController;
    }
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)openAppSettings{
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if( [[UIApplication sharedApplication]canOpenURL:url] ) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
