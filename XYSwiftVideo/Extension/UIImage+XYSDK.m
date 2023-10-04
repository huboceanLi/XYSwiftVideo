//
//  UIImage+XYSDK.m
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/10/4.
//

#import "UIImage+XYSDK.h"

@implementation UIImage (XYSDK)

+ (UIImage *)xysdk_bundleImage:(NSString *)imageName {

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"HYVideoSDK" withExtension:@"bundle"];
    NSBundle *b = [NSBundle bundleWithURL:url];
    if (b) {
        if (@available(iOS 13.0, *)) {
            UIImage *img = [UIImage imageNamed:imageName inBundle:b withConfiguration:nil];
            return img;
        } else {
            return [UIImage imageWithContentsOfFile:url.path];
        }
    }
    
    return nil;
      
}
@end
