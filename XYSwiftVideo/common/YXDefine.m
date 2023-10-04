//
//  YXDefine.m
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/8/24.
//

#import "YXDefine.h"
#import <QMUIKit/QMUIKit.h>
#import "XYSwiftVideo/XYSwiftVideo-Swift.h"
#import <YYModel/YYModel.h>
#import "LHYLocaColletion.h"

#define IS_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

@implementation YXDefine

+ (BOOL)isPhoneX {
    if (IS_iPhoneX) {
        return YES;
    }
    return NO;
}

+ (void)popWithSender:(UINavigationController *)sender {
    [self popWithSender:sender animated:YES];
}

+ (void)popWithSender:(UINavigationController *)sender animated:(BOOL)animated {
    if (!sender) {
        return;
    }
    if (sender.viewControllers.count <= 0) {
        return;
    }
    else {
        [sender.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (sender.viewControllers.count - 1 > idx) {
                [sender popToViewController:obj animated:animated];
                *stop = YES;
            }
        }];
    }
}

+ (void)dismissWhithDestination:(UIViewController *)destination{
    if (!destination) {
        return;
    }
    
    [destination dismissViewControllerAnimated:YES completion:nil];
}

+ (UINavigationController *)getNavigationController {
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
   if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
       return (UINavigationController *)window.rootViewController;
   } else if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
       UIViewController *selectedVC = [((UITabBarController *)window.rootViewController)selectedViewController];
       if ([selectedVC isKindOfClass:[UINavigationController class]]) {
           return (UINavigationController *)selectedVC;
       }
   }
   return nil;
}

+ (void)savePlay:(YXHistoryRecordModel *)model
{
    
    NSString *s = [self getTimeNow];
    model.creatTime = [s integerValue];
    
    NSString *jsonStr = [model yy_modelToJSONString];
    NSMutableDictionary *historyDic = [[LHYLocaColletion getDictionaryFile:@"HISTORY"] mutableCopy];
    [historyDic setObject:jsonStr forKey:[NSString stringWithFormat:@"%ld",model.tvId]];
    [LHYLocaColletion saveDictionaryFile:historyDic AndFileName:@"HISTORY"];
}

+ (NSArray <YXHistoryRecordModel *>*)getHistory
{
    NSMutableDictionary *historyDic = [[LHYLocaColletion getDictionaryFile:@"HISTORY"] mutableCopy];
    
    NSArray *keys = historyDic.allKeys;
    
    NSMutableArray *lastModels = [NSMutableArray array];
    
    for (NSString *tid in keys) {
        NSString *jsonStr = historyDic[tid];
        YXHistoryRecordModel *model = [YXHistoryRecordModel yy_modelWithJSON:jsonStr];
        [lastModels addObject:model];
    }
    
    if (lastModels.count > 0) {
        NSSortDescriptor *ageSortDescriptorDescending = [NSSortDescriptor sortDescriptorWithKey:@"creatTime" ascending:NO];
        NSArray *sortedPeopleDescending = [lastModels sortedArrayUsingDescriptors:@[ageSortDescriptorDescending]];
        
        return sortedPeopleDescending;
    }
    return @[];
}

+ (NSArray *)getHistoryAllkeys
{
    NSMutableDictionary *historyDic = [[LHYLocaColletion getDictionaryFile:@"HISTORY"] mutableCopy];
    
    NSArray *keys = historyDic.allKeys;
    if (keys.count == 0) {
        return @[];
    }
    return keys;
}

+ (void)removeFile {
    
    NSString *string = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"HISTORY"]];
    [[NSFileManager defaultManager] removeItemAtPath:string error:nil];
}

+ (NSString *) getTimeNow {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // 设置想要的格式，hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这一点对时间的处理很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *dateNow = [NSDate date];

    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[dateNow timeIntervalSince1970]];
    
    return timeStamp;
}

+ (NSString *)changeTimeWithDuration:(NSInteger)duration {
    
    if (duration > 0) {
        
        NSInteger hou = duration % (60 * 60 * 24) / 3600;
        NSInteger min = duration % (60 * 60 * 24) % 3600 / 60;
        NSInteger sec = duration % (60 * 60 * 24) % 3600 % 60;

        if (hou > 0) {
            return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hou,min,sec];
        }
        return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    }

    return @"00:00";
}

+ (NSMutableAttributedString *)attributedString:(NSString *)t name:(NSString *)name j:(NSString *)j
{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",t,name,j]];
    
//    att.yy_font = [UIFont systemFontOfSize:13];
    [att addAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor],NSFontAttributeName: [UIFont systemFontOfSize:13]} range:NSMakeRange(0, t.length)];
    [att addAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont systemFontOfSize:13]} range:NSMakeRange(t.length, name.length)];
    [att addAttributes:@{NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"4F80FF"],NSFontAttributeName: [UIFont boldSystemFontOfSize:13]} range:NSMakeRange(name.length + t.length, j.length)];
    
    
    return att;
}

@end
