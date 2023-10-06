//
//  YXDefine.h
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/8/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YXHistoryRecordModel;

@interface YXDefine : NSObject

+ (BOOL)isPhoneX;
+ (void)popWithSender:(UINavigationController *)sender;
+ (void)dismissWhithDestination:(UIViewController *)destination;
+ (UINavigationController *)getNavigationController;

//获取历史
+ (NSArray <YXHistoryRecordModel *>*)getHistory;

+ (NSArray *)getHistoryAllkeys;

+ (NSString *)changeTimeWithDuration:(NSInteger)duration;

+ (NSMutableAttributedString *)attributedString:(NSString *)t name:(NSString *)name j:(NSString *)j;

+ (void)removeFile;

//存储播放记录
//- (void)savePlay:(NSString *)tvID name:(NSString *)name playUrl:(NSString *)playUrl imageUrl:(NSString *)imageUrl duration:(NSInteger)duration playDuration:(NSInteger)playDuration playName:(NSString *)playName;

+ (void)savePlay:(YXHistoryRecordModel *)model;

+ (void)saveADKey:(NSString *)key;

+ (BOOL)getADKey;


+ (void)saveJLADKey:(BOOL)key;

+ (BOOL)getADJLKey;

@end

NS_ASSUME_NONNULL_END
