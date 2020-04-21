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
   [locManager requestWhenInUseAuthorization];
    
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
    //定位处理
    self.locationManager = manager;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
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
