//
//  QYMLocationModel.h
//  QYMKit
//
//  Created by Jack Luo on 2019/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYMLocationModel : NSObject

/** 经度 */
@property (nonatomic, assign) double longitude;
/** 纬度 */
@property (nonatomic, assign) double latitude;
/** 国家 */
@property (nonatomic, copy) NSString *country;
/** 省 */
@property (nonatomic, copy) NSString *administrativeArea;
/** 副省 */
@property (nonatomic, copy) NSString *subAdministrativeArea;
/** 市 */
@property (nonatomic, copy) NSString *locality;
/** 区 */
@property (nonatomic, copy) NSString *subLocality;
/** 街道 */
@property (nonatomic, copy) NSString *thoroughfare;
/** 名牌号 */
@property (nonatomic, copy) NSString *subThoroughfare;
/** 地区码 */
@property (nonatomic, copy) NSString *areaCode;
/** city编码 */
@property (nonatomic, copy) NSString *cityCode;
/** 定位时间 */
@property (nonatomic, strong) NSDate *date;


/** 交易城市信息,如locality为空，则传subLocality */
- (NSString *)getTradeCity;

/** 详细地址 */
- (NSString *)detailAddr;

/** 格式地址 */
- (NSString *)formatAddr;


@end

NS_ASSUME_NONNULL_END
