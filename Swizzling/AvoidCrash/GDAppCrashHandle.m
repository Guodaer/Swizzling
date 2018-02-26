//
//  GDAppCrashHandle.m
//  Swizzling
//
//  Created by moqing on 2018/2/24.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "GDAppCrashHandle.h"

@implementation GDAppCrashHandle

- (void)defaultSafeMethod {
//    AvoidCrashLog(@"方法崩溃了🍎🍎🍎🍎");
//    NSException
//    [GDAppCrashHandle noteErrorWithException:nil defaultToDo:@"崩溃方法Selector"];
}

/**
 *  提示崩溃的信息(控制台输出、通知)
 *
 *  @param exception   捕获到的异常
 *  @param defaultToDo 这个框架里默认的做法
 */
+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo {
    
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [GDAppCrashHandle getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    
    if (mainCallStackSymbolMsg == nil) {
        
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
        
    }
    
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    //errorReason 可能为 -[__NSCFConstantString avoidCrashCharacterAtIndex:]: Range or index out of bounds
    //将avoidCrash去掉
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"avoidCrash" withString:@""];
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@",AvoidCrashSeparatorWithFlag, errorName, errorReason, errorPlace, defaultToDo];
    
    logErrorMessage = [NSString stringWithFormat:@"%@\n\n%@\n\n",logErrorMessage,AvoidCrashSeparator];
    AvoidCrashLog(@"%@",logErrorMessage);
    
    
    //请忽略下面的赋值，目的只是为了能顺利上传到cocoapods
//    logErrorMessage = logErrorMessage;
    
//    NSDictionary *errorInfoDic = @{
//                                   key_errorName        : errorName,
//                                   key_errorReason      : errorReason,
//                                   key_errorPlace       : errorPlace,
//                                   key_defaultToDo      : defaultToDo,
//                                   key_exception        : exception,
//                                   key_callStackSymbols : callStackSymbolsArr
//                                   };
//
//    //将错误信息放在字典里，用通知的形式发送出去
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:errorInfoDic];
//    });
}


/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    return mainCallStackSymbolMsg;
}

@end
