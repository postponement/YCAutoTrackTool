//
//  YCTrackTool.m
//  YCAutoTrackTool
//
//  Created by liuyanchi on 2018/7/8.
//  Copyright © 2018年 yidaoyongche. All rights reserved.
//

#import "YCTrackTool.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "Aspects.h"
#import "YCStrackDataHandler.h"
#import "YCStatisticManager.h"

@implementation YCTrackTool

- (void)yc_trackHooks
{
    [[YCStatisticManager sharedManager] configStatisticParams];
    [self hookViewAppear];
    [self hookBttonEvent];
}


/**
 用户时长,viewWillAppear---viewWillDisappear
 */
- (void)hookViewAppear
{
    
    NSError *errorA = nil;
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   
                                   NSString *classStr =NSStringFromClass([[info instance] class]);
                                   NSDictionary *dict = [YCStrackDataHandler shareInstance].dataDict[classStr];
                                   if (dict[@"isAdd"]) {
                                       NSString *pageName = dict[@"viewWillAppear"];
                                       [[YCStatisticManager sharedManager] umengBeginLogPageView:pageName];
                                   }
                               }
                                    error:&errorA];
    if (errorA) {
        
        NSLog(@"%@",errorA);
        
    }
    
    NSError *errorB = nil;
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   
                                   NSString *classStr =NSStringFromClass([[info instance] class]);
                                    NSDictionary *dict = [YCStrackDataHandler shareInstance].dataDict[classStr];
                                   if (dict[@"isAdd"]) {
                                       NSString *pageName = dict[@"viewWillDisappear"];
                                       [[YCStatisticManager sharedManager] umengEndLogPageView:pageName];
                                   }
                               }
                                    error:&errorB];
    if (errorB) {
        
        NSLog(@"%@",errorB);
        
    }
}


/**
 按钮点击事件
 */
- (void)hookBttonEvent
{
    
    // 异步执行hook操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSString *classNameStr in [YCStrackDataHandler shareInstance].dataDict.allKeys) {
            Class tempClass = objc_getClass([classNameStr UTF8String]);
            
            NSDictionary *pageListDict = [[YCStrackDataHandler shareInstance].dataDict objectForKey:classNameStr];
            NSArray *tempArray = pageListDict[@"subviews"];
            for (NSDictionary *eventDict in tempArray) {
                NSString *eventMethodName = eventDict[@"MethodName"];
                SEL seletor = NSSelectorFromString(eventMethodName);
                NSString *eventId = eventDict[@"EventId"];
                BOOL isAddUM = eventDict[@"isNeedAddUM"];
                [self hookActionWithClass:tempClass selector:seletor eventID:eventId isNeedAddUM:isAddUM];
                [self hookTabaleViewCellEventWithClass:tempClass selector:seletor eventID:eventId isNeedAddUM:isAddUM];
                [self hookActionWithParamWithClass:tempClass selector:seletor eventID:eventId isNeedAddUM:isAddUM];
            }
        }
    });
}

/**
 按钮/手势,点击事件(无参)
 */
-(void)hookActionWithClass:(Class)tempClass selector:(SEL)selector eventID:(NSString*)eventID isNeedAddUM:(BOOL)isNeedAddUM
{
    NSError *error = nil;
    [tempClass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        if (isNeedAddUM) {
            [[YCStatisticManager sharedManager] umengEvent:eventID];
        }
    } error:&error];
    
    if (error) {
        NSLog(@"%@",error);
        
    }
}


/**
 按钮点击事件(有参)
 */
- (void)hookActionWithParamWithClass:(Class)tempClass selector:(SEL)selector eventID:(NSString*)eventID isNeedAddUM:(BOOL)isNeedAddUM
{
    NSError *error = nil;
    [tempClass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,UIButton *button) {
        
//        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        if (isNeedAddUM) {
            [[YCStatisticManager sharedManager] umengEvent:eventID];
        }
    } error:&error];
    
    if (error) {
        NSLog(@"%@",error);
        
    }
}


/**
 cell点击事件
 */
- (void)hookTabaleViewCellEventWithClass:(Class)tempClass selector:(SEL)selector eventID:(NSString*)eventID isNeedAddUM:(BOOL)isNeedAddUM
{
    
    NSError *error;
    [tempClass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSSet *touches, UIEvent *event) {
        
//        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSInteger section = [[event valueForKeyPath:@"section"]integerValue];
        NSInteger row = [[event valueForKeyPath:@"row"]integerValue];
        // 根据自己的情况而定
        if (section == 0 && row == 0) {
            [[YCStatisticManager sharedManager] umengEvent:eventID];
        }
    } error:&error];
    
    if (error) {
        NSLog(@"%@",error);
        
    }
}

@end
