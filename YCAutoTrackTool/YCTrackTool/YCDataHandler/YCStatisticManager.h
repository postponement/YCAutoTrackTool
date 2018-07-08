//
//  YCStatisticManager.h
//  YCAutoTrackTool
//
//  Created by liuyanchi on 2018/7/8.
//  Copyright © 2018年 yidaoyongche. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 友盟封装类,如需添加其他方法,请自行添加
 */
@interface YCStatisticManager : NSObject

+ (instancetype)sharedManager;


/**
 有关配置写到这个方法里面
 */
- (void)configStatisticParams;

- (void)umengEvent:(NSString *)eventId;

- (void)umengEvent:(NSString*)eventId
        attributes:(NSDictionary*)attributes;

- (void)umengEvent:(NSString*)eventId
             label:(NSString*)label;

- (void)umengBeginLogPageView:(NSString *)pageName;

- (void)umengEndLogPageView:(NSString *)pageName;


@end
