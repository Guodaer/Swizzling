//
//  NSMutableArray+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/8.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import <objc/runtime.h>
#import "GDAppCrashHandle.h"
@implementation NSMutableArray (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        NSLog(@"%@",objc_getClass("__NSArrayM"));
        
        //removeObject:
        [self swizzleSelector:@selector(removeObject:) withSwizzledSelector:@selector(safeRemoveObject:)];
        
        //addObject:
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:) withSwizzledSelector:@selector(safeAddObject:)];
        
        //removeObjectAtIndex:
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
        
        //insertObject:atIndex:
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(safeInsertObject:atIndex:)];
        
        //initWithObjects:count:
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:) withSwizzledSelector:@selector(safeInitWithObjects:count:)];
        
        //objectAtIndex:
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeObjectAtIndex:)];
        
        //objectAtIndexedSubscript
        if (AvoidCrashIsiOS(11.0)) {
            [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safeObjectAtIndexedSubscript:)];
        }
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(getObjects:range:) withSwizzledSelector:@selector(safeGetObjects:range:)];

    });
}


- (instancetype)safeInitWithObjects:(const id _Nonnull  __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    @try {
        instance = [self safeInitWithObjects:objects count:cnt];
    }
    @catch(NSException *exception) {
        NSString *defaultToDo = @"AvoidCrash 初始化数组时有 空 对象";
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i=0; i<cnt; i++) {//0,1,2,3,4
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        instance = [self safeInitWithObjects:newObjects count:index];
    }
    @finally {
        return  instance;
    }
    
}

#pragma mark - getObjects:range:
- (void)safeGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self safeGetObjects:objects range:range];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

#pragma mark - ObjectAtIndexedSubscript:
- (id) safeObjectAtIndexedSubscript:(NSInteger)idx {
    id object = nil;
    
    @try {
        object = [self safeObjectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

#pragma mark - safeAddObject:
- (void)safeAddObject:(id)objc {
    @try{
        [self safeAddObject:objc];
    }
    @catch(NSException *exception) {
        NSString *message = @"添加对象为空";
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:message];
    }
    @finally {

    }
    
}
#pragma mark - RemoveObject
- (void)safeRemoveObject:(id)obj {
    @try {
        [self safeRemoveObject:obj];
    }
    @catch (NSException *exception) {
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}
#pragma mark - InsertObject
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self safeInsertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
    
    }
}
#pragma mark - objectAtIndex
- (id)safeObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self safeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}
#pragma mark - RemoveObjectAtIndex
- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self safeRemoveObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
  
    
}
@end
