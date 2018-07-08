//
//  YCStrackDataHandler.h
//  AopTestDemo
//
//  Created by liuyanchi on 2018/7/8.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCStrackDataHandler : NSObject

@property (nonatomic, strong) NSDictionary *dataDict;

+ (instancetype)shareInstance;

@end
