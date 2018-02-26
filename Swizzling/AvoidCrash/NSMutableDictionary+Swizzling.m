//
//  NSMutableDictionary+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/26.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSMutableDictionary+Swizzling.h"
#import "GDAppCrashHandle.h"
@implementation NSMutableDictionary (Swizzling)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");

        [dictionaryM swizzleSelector:@selector(setObject:forKey:) withSwizzledSelector:@selector(avoidCrashSetObject:forKey:)];
        
        [dictionaryM swizzleSelector:@selector(setObject:forKeyedSubscript:) withSwizzledSelector:@selector(avoidCrashSetObject:forKeyedSubscript:)];
        
        [dictionaryM swizzleSelector:@selector(removeObjectForKey:) withSwizzledSelector:@selector(avoidCrashRemoveObjectForKey:)];
        
    });
}
//=================================================================
//                       setObject:forKey:
//=================================================================
#pragma mark - setObject:forKey:

- (void)avoidCrashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self avoidCrashSetObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                  setObject:forKeyedSubscript:
//=================================================================
#pragma mark - setObject:forKeyedSubscript:
- (void)avoidCrashSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self avoidCrashSetObject:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)avoidCrashRemoveObjectForKey:(id)aKey {
    
    @try {
        [self avoidCrashRemoveObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}
@end
