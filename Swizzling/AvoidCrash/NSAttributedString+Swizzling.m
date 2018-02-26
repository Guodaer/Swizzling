//
//  NSAttributedString+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/26.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSAttributedString+Swizzling.h"
#import "GDAppCrashHandle.h"
@implementation NSAttributedString (Swizzling)
//=================================================================
//                           initWithString:
//=================================================================
#pragma mark - initWithString:

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSConcreteAttributedString = NSClassFromString(@"NSConcreteAttributedString");
        
        //initWithString:
        [NSConcreteAttributedString swizzleSelector:@selector(initWithString:) withSwizzledSelector:@selector(avoidCrashInitWithString:)];
        
        //initWithAttributedString
        [NSConcreteAttributedString swizzleSelector:@selector(initWithAttributedString:) withSwizzledSelector:@selector(avoidCrashInitWithAttributedString:)];
        
        
        //initWithString:attributes:
        [NSConcreteAttributedString swizzleSelector:@selector(initWithString:attributes:) withSwizzledSelector:@selector(avoidCrashInitWithString:attributes:)];
    });
    

}

- (instancetype)avoidCrashInitWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                          initWithAttributedString
//=================================================================
#pragma mark - initWithAttributedString

- (instancetype)avoidCrashInitWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                      initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:

- (instancetype)avoidCrashInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

@end
