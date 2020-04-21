//
//  QYMErrorCodeConfig.h
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#ifndef QYMErrorCodeConfig_h
#define QYMErrorCodeConfig_h


typedef NS_ENUM(NSInteger, QYMLocationCode) {
    QYMLocationCodeSuccess = 0, //成功
    QYMLocationCodeServicesEnableFail = 4001, //系统未开启授权
    QYMLocationCodeUseReject          = 4002, //用户拒绝授权
    QYMLocationCodeLoading            = 4050, //正在定位中
};


#endif /* QYMErrorCodeConfig_h */
