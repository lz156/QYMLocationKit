//
//  QYMLocationModelCacheManager.h
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

/**************************************************
 model缓存管理
 **************************************************/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYMModelCacheManager : NSObject


/// 保存model到本地
/// @param path 保存路径；传空时，默认qymloc文件
/// @param model 数据model;如是自定义对象需实现NSCoding
/// @param resultBlock 结果回调
+ (void)saveModelToLocalWithSavePath:(NSString * _Nullable)path
                               model:(id)model
                               block:(void(^)(BOOL success))resultBlock;


/// 本地读取model
/// @param path 文件路径， 传空时，默认qymloc文件
+ (id)readeLocationModelFromLocalWithPath:(NSString * _Nullable)path;

/// 删除model
/// @param path 文件路径， 传空时，默认qymloc文件
+ (void)deleteSaveLocationModelWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
