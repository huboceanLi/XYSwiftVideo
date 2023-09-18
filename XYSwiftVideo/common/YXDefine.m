//
//  YXDefine.m
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/8/24.
//

#import "YXDefine.h"
#import <QMUIKit/QMUIKit.h>

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

@end
