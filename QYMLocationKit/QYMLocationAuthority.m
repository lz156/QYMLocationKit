//
//  QYMLocationAuthority.m
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import "QYMLocationAuthority.h"
#import "QYMLocationManager.h"

@interface  QYMLocationAuthority()
///定位
@property (nonatomic, strong) CLLocationManager *locManager;

@end


@implementation QYMLocationAuthority

+ (instancetype)share{
    
    static QYMLocationAuthority *authority = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authority = [[QYMLocationAuthority alloc] init];
    });
    return authority;
}

#pragma mark -
+ (BOOL)locationServicesEnabled{
    return [CLLocationManager locationServicesEnabled];
}

+ (CLAuthorizationStatus)locationAuthorizationStatus{

    if(@available(iOS 14.0, *)){
        [QYMLocationAuthority share].locManager = [[CLLocationManager alloc] init];
        return  [QYMLocationAuthority share].locManager.authorizationStatus;
    }
    else{
        return [CLLocationManager authorizationStatus];
    }
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


+ (BOOL)checkLocAuthorizationAndShowAlertWithVC:(UIViewController *)inVC{
    
    if ([self checkLocAuthorization]) {
        return YES;
    }
    else{
        if (![self locationServicesEnabled]) {
            [self showAlertWithTitle:@"打开定位开关"
                             message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)"
                                inVC:inVC];
        }
        else if([self locationAuthorizationStatus] == kCLAuthorizationStatusNotDetermined){
            
        }
        else{
            NSString *appName = [self appBundleDisplayName];
            NSString *msg = [NSString stringWithFormat:@"请在系统设置中开启定位服务(设置>隐私>定位服务>%@>使用应用期间)",appName];
            [self showAlertWithTitle:@"打开定位服务权限" message:msg inVC:inVC];
        }
    }
    
    return NO;
}

#pragma mark - App显示名称
+ (NSString *)appBundleDisplayName{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

#pragma mark -
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message inVC:(UIViewController *)inVC{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        [self openAppSettings];
    }]];
    
    UIViewController *vc = inVC;
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)openAppSettings{
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if( [[UIApplication sharedApplication]canOpenURL:url] ) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

@end
