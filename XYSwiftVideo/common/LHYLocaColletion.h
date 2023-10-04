//
//  LHYLocaColletion.h
//  TabBarNav
//
//  Created by HappyMilk 02 on 2017/12/20.
//  Copyright © 2017年 nike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHYLocaColletion : NSObject

//存储字典类型文件
+ (BOOL)saveDictionaryFile:(NSDictionary *)dic AndFileName:(NSString *)fileName;
//获取字典文件
+ (NSDictionary *)getDictionaryFile:(NSString *)fileName;


//存储数组类型文件
+ (BOOL)saveArrayFile:(NSArray *)dic AndFileName:(NSString *)fileName;
//获取数组类型文件
+ (NSArray *)getArrayFile:(NSString *)fileName;

@end
