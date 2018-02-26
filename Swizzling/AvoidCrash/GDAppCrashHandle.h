//
//  GDAppCrashHandle.h
//  Swizzling
//
//  Created by moqing on 2018/2/24.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+Swizzling.h"
#import "NSMutableArray+Swizzling.h"


#define key_errorName        @"errorName"
#define key_errorReason      @"errorReason"
#define key_errorPlace       @"errorPlace"
#define key_defaultToDo      @"defaultToDo"
#define key_callStackSymbols @"callStackSymbols"
#define key_exception        @"exception"


#define AvoidCrashNotification @"AvoidCrashNotification"

#define AvoidCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

//user can ignore below define
#define AvoidCrashDefaultReturnNil  @"AvoidCrash default is to return nil to avoid crash."
#define AvoidCrashDefaultIgnore     @"AvoidCrash default is to ignore this operation to avoid crash."

#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="

//崩溃Log
#ifdef DEBUG
#define  AvoidCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define AvoidCrashLog(...)
#endif


@interface GDAppCrashHandle : NSObject


//防止崩溃的默认方法
- (void)defaultSafeMethod;
//catch到崩溃信息打新出来
+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;

@end
