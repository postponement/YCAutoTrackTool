//
//  YCStrackDataHandler.m
//  AopTestDemo
//
//  Created by liuyanchi on 2018/7/8.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "YCStrackDataHandler.h"

@implementation YCStrackDataHandler

+ (instancetype)shareInstance
{
   static YCStrackDataHandler *instance;
   static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[YCStrackDataHandler alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

- (void)configData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YCTrack.plist" ofType:nil];
    
    self.dataDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
}



@end
