//
//  NSDictionary+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/24.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSDictionary+Swizzling.h"
#import "GDAppCrashHandle.h"
#import <objc/runtime.h>

@implementation NSDictionary (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");

        [self swizzleSelector:@selector(dictionaryWithObjects:forKeys:count:) withSwizzledSelector:@selector(avoidCrashDictionaryWithObjects:forKeys:count:)];
        
        
        [__NSDictionaryM swizzleSelector:@selector(initWithObjects:forKeys:count:) withSwizzledSelector:@selector(safeInitWithObjects:forKeys:count:)];
        [__NSPlaceholderDictionary swizzleSelector:@selector(initWithObjects:forKeys:count:) withSwizzledSelector:@selector(safeInitWithObjects:forKeys:count:)];

    });
}

- (instancetype)safeInitWithObjects:(const id _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    id instance = nil;
    
    @try {
        instance = [self safeInitWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"AvoidCrash default is to remove nil key-values and instance a safeInitWithObjects.";
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safeInitWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

+ (instancetype)avoidCrashDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self avoidCrashDictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"AvoidCrash default is to remove nil key-values and instance a dictionary.";
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self avoidCrashDictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}


@end
