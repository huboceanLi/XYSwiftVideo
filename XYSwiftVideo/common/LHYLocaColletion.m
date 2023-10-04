//
//  LHYLocaColletion.m
//  TabBarNav
//
//  Created by HappyMilk 02 on 2017/12/20.
//  Copyright © 2017年 nike. All rights reserved.
//

#import "LHYLocaColletion.h"

@implementation LHYLocaColletion

//存字典
+ (BOOL)saveDictionaryFile:(NSDictionary *)dic AndFileName:(NSString *)fileName{
    
    
    NSString *string = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    return [dic writeToFile:string atomically:YES];
}
//获取
+ (NSDictionary *)getDictionaryFile:(NSString *)fileName;{
    
    
    NSString *string = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:string]) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:string];
        return dic;
    }else{
        return @{};
    }
}


//存储数组类型文件
+ (BOOL)saveArrayFile:(NSArray *)array AndFileName:(NSString *)fileName{
    
    
    NSString *string = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    return [array writeToFile:string atomically:YES];
}

//获取数组类型文件
+ (NSArray *)getArrayFile:(NSString *)fileName{
    
    NSString *string = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:string]) {
        
        NSArray *array = [NSArray arrayWithContentsOfFile:string];
        return array;
    }else{
        return @[];
    }
}

@end
