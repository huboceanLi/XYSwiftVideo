//
//  YXDefine.h
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/8/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXDefine : NSObject

+ (BOOL)isPhoneX;
+ (void)popWithSender:(UINavigationController *)sender;
+ (void)dismissWhithDestination:(UIViewController *)destination;

@end

NS_ASSUME_NONNULL_END
