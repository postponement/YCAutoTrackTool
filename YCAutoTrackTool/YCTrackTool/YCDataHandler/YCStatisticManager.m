//
//  YCStatisticManager.m
//  YCAutoTrackTool
//
//  Created by liuyanchi on 2018/7/8.
//  Copyright © 2018年 yidaoyongche. All rights reserved.
//

#import "YCStatisticManager.h"
#import <UMAnalytics/MobClick.h>
#import <UMCommon/UMCommon.h>

@implementation YCStatisticManager

+ (instancetype)sharedManager
{
    static YCStatisticManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YCStatisticManager alloc] init];
    });

    return instance;
}

- (void)configStatisticParams
{
     [UMConfigure initWithAppkey:@"5b41cf208f4a9d2d65000257" channel:nil];
}

- (void)umengEvent:(NSString*)eventId {
    [MobClick event:eventId];
}

- (void)umengEvent:(NSString*)eventId
        attributes:(NSDictionary*)attributes
{
    [MobClick event:eventId attributes:attributes];
}

- (void)umengEvent:(NSString*)eventId
             label:(NSString*)label
{
    [MobClick event:eventId label:label];
}

- (void)umengBeginLogPageView:(NSString *)pageName
{
    [MobClick beginLogPageView:pageName];
}

- (void)umengEndLogPageView:(NSString *)pageName
{
    [MobClick endLogPageView:pageName];
}


@end
