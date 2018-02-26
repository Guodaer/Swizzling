//
//  NSObject+AvoidCrash.m
//  Swizzling
//
//  Created by moqing on 2018/2/26.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSObject+AvoidCrash.h"
#import "GDAppCrashHandle.h"
@implementation NSObject (AvoidCrash)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //setValue:forKey:
        [self swizzleSelector:@selector(setValue:forKey:) withSwizzledSelector:@selector(avoidCrashSetValue:forKey:)];
        
        //setValue:forKeyPath:
        [self swizzleSelector:@selector(setValue:forKeyPath:) withSwizzledSelector:@selector(avoidCrashSetValue:forKeyPath:)];

        //setValue:forUndefinedKey:
        [self swizzleSelector:@selector(setValue:forUndefinedKey:) withSwizzledSelector:@selector(avoidCrashSetValue:forUndefinedKey:)];
        
        //setValuesForKeysWithDictionary:
        [self swizzleSelector:@selector(setValuesForKeysWithDictionary:) withSwizzledSelector:@selector(avoidCrashSetValuesForKeysWithDictionary:)];

        [self swizzleSelector:@selector(forwardInvocation:) withSwizzledSelector:@selector(avoidCrashForwardInvocation:)];
        [self swizzleSelector:@selector(methodSignatureForSelector:) withSwizzledSelector:@selector(safe_methodSignatureForSelector:)];
    });
    
}


- (NSMethodSignature *)safe_methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"333333333");
        NSMethodSignature *ms = [self safe_methodSignatureForSelector:aSelector];
        if (ms == nil) {
            ms = [GDAppCrashHandle instanceMethodSignatureForSelector:@selector(defaultSafeMethod)];
        }
        return ms;

}



- (void)avoidCrashForwardInvocation:(NSInvocation *)anInvocation {
    
//    SEL selector = [anInvocation selector];
//
//    if ([self respondsToSelector:selector]) {
//        [self avoidCrashForwardInvocation:anInvocation];
//    }else {
//        [GDAppCrashHandle noteErrorWithException:nil defaultToDo:@"selectorMethod 不存在"];
//    }
    
    @try {
        [self avoidCrashForwardInvocation:anInvocation];
//
    } @catch (NSException *exception) {
//
////        NSString *defaultToDo = AvoidCrashDefaultIgnore;
////        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
//
    } @finally {

    }

}
//=================================================================
//                         setValue:forKey:
//=================================================================
#pragma mark - setValue:forKey:

- (void)avoidCrashSetValue:(id)value forKey:(NSString *)key {
    @try {
        [self avoidCrashSetValue:value forKey:key];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//                     setValue:forKeyPath:
//=================================================================
#pragma mark - setValue:forKeyPath:

- (void)avoidCrashSetValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self avoidCrashSetValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}



//=================================================================
//                     setValue:forUndefinedKey:
//=================================================================
#pragma mark - setValue:forUndefinedKey:

- (void)avoidCrashSetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self avoidCrashSetValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//                  setValuesForKeysWithDictionary:
//=================================================================
#pragma mark - setValuesForKeysWithDictionary:

- (void)avoidCrashSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    @try {
        [self avoidCrashSetValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}
@end
