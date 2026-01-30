//
//  LocationManager.m
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import "QYMLocationManager.h"
#import "QYMLocationAuthority.h"
#import "QYMErrorCodeConfig.h"

@interface QYMLocationManager ()<CLLocationManagerDelegate>
/** 定位管理 */
@property (nonatomic, strong) CLLocationManager *locationManager;
/** 正在定位 */
@property (nonatomic, assign) BOOL isLoading;
/**  */
@property (nonatomic, strong) LocationResultBlock resultBlock;

@end

@implementation QYMLocationManager

- (void)startLocationWithResutlBlock:(LocationResultBlock)resultBlock{
    
    CLLocationManager *locManager = [[CLLocationManager alloc] init];
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    locManager.distanceFilter  = kCLDistanceFilterNone;
    
    [self startLocationWithManager:locManager
                             block:resultBlock];
}

- (void)startLocationWithManager:(CLLocationManager *)manager block:(LocationResultBlock)resultBlock{
    
    if (![QYMLocationAuthority locationServicesEnabled]) {
           NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                code:QYMLocationCodeServicesEnableFail
                                            userInfo:@{NSLocalizedDescriptionKey:@"GPS未开启"}];
           if (resultBlock) {
               resultBlock(NO,nil,error);
           }
           return;
       }
       
       CLAuthorizationStatus status = [QYMLocationAuthority locationAuthorizationStatus];
       if (status == kCLAuthorizationStatusRestricted ||
           status == kCLAuthorizationStatusDenied) {
           
           NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                code:QYMLocationCodeUseReject
                                            userInfo:@{NSLocalizedDescriptionKey:@"未获取定位权限"}];
           if (resultBlock) {
               resultBlock(NO,nil,error);
           }
           return;
       }
       
       if (self.isLoading == YES) {
           
           NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                       code:QYMLocationCodeLoading
                                                   userInfo:@{NSLocalizedDescriptionKey:@"正在定位中"}];
          if (resultBlock) {
              resultBlock(NO,nil,error);
          }
          return;
       }
       
    //开始定位
    self.isLoading = YES;
    self.resultBlock = resultBlock;
    //定位处理
    self.locationManager = manager;
    self.locationManager.delegate = self;
}

#pragma mark - 取消定位
- (void)cancelLocation{
    self.isLoading = NO;
    [self deinitLocationManager];
    if (self.resultBlock) {
        self.resultBlock = nil;
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager{
    CLAuthorizationStatus status = manager.authorizationStatus;
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:{
            
            NSLog(@"用户还未决定授权");
            // 主动获得授权
            [self.locationManager requestWhenInUseAuthorization];
            break;
        }
            
        case kCLAuthorizationStatusRestricted:{
            
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:{
            
            // 此时使用主动获取方法也不能申请定位权限
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                
                NSLog(@"定位服务开启，被拒绝");
            } else {
                
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:{
            
            [self.locationManager startUpdatingLocation];
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            
            [self.locationManager startUpdatingLocation];
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    [self deinitLocationManager];
    if (self.resultBlock) {
        self.resultBlock(manager,locations,nil);
        self.resultBlock = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    [self deinitLocationManager];
    if (self.resultBlock) {
        self.resultBlock(NO,nil,error);
        self.resultBlock = nil;
    }
}

#pragma mark -
- (void)deinitLocationManager{
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

@end
