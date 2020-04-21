//
//  QYMLocationModelCacheManager.m
//  QYMKit
//
//  Created by Jack on 2020/4/20.
//

#import "QYMModelCacheManager.h"
#import "QYMLocationModel.h"

@implementation QYMModelCacheManager

#pragma mark - 保存model到本地
+ (void)saveModelToLocalWithSavePath:(NSString *)path
                               model:(id)model
                               block:(void(^)(BOOL success))resultBlock{
    
    if (model) {
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *filePath = path.length > 0 ? path : [self locationModelPath];
            BOOL success = [NSKeyedArchiver archiveRootObject:model toFile:filePath];
            if (!success) {
                NSLog(@"loc失败");
            }
            else{
                //设置文件不同步
                [self addSkipBackupAttributeToItemAtPath:[self locationModelPath]];
                NSLog(@"loc保存成功");
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resultBlock) {
                    resultBlock(success);
                }
            });
        });
    }
    else{
        if (resultBlock) {
            resultBlock(NO);
        }
    }
}
#pragma mark - 从本地读取Model
+ (id)readeLocationModelFromLocalWithPath:(NSString *)path{
    
    NSString *filePath = path.length > 0 ? path : [self locationModelPath];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    if (data) {
        id cacheModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return cacheModel;
    }
    return nil;
}

#pragma mark - 删除model
+ (void)deleteSaveLocationModelWithPath:(NSString *)path{
    
    NSString *filePath = path.length > 0 ? path : [self locationModelPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath
                                                   error:nil];
    }
}

#pragma mark - 私有方法
+ (NSString *)locationModelPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path = nil;
    if (paths.count > 0) {
        path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@"qymloc"];
    }
    return path;
}

#pragma mark - 设置缓存文件不同步
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePath{
    
    NSURL* URL= [NSURL fileURLWithPath:filePath];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

@end
