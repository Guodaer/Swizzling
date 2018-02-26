//
//  NSObject+AvoidCrash.m
//  Swizzling
//
//  Created by moqing on 2018/2/26.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSObject+AvoidCrash.h"
#import "GDAppCrashHandle.h"
#import <objc/runtime.h>
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

//forwardingTargetForSelector
- (NSMethodSignature *)safe_methodSignatureForSelector:(SEL)aSelector{
//    NSLog(@"333333333");
//        NSMethodSignature *ms = [self safe_methodSignatureForSelector:aSelector];
//        if (ms == nil) {
//            ms = [GDAppCrashHandle instanceMethodSignatureForSelector:@selector(defaultSafeMethod)];
//        }
//        return ms;
    
    //默认先调用原始方法，判断用户有没有对此进行处理，如果没有就会unrecognized异常，这里就要加上处理
    NSMethodSignature *ms = [self safe_methodSignatureForSelector:aSelector];
    if (ms == nil) {
        if (![self respondsToSelector:aSelector]) {
            //动态的给一个实例添加一个方法，去处理这个unrecognized selector
            class_addMethod([self class], aSelector, (IMP)dynamicAdditionMethodIMP, "v@:");
        }
        ms = [self methodSignatureForSelector:aSelector];
        
    }
    return ms;
    
}

//假设须要传參直接在參数列表后面加入就好了
void dynamicAdditionMethodIMP(id self, SEL _cmd) {
//    NSLog(@"dynamicAdditionMethodIMP");
    NSString *selector_Name = NSStringFromSelector(_cmd);
    NSString *class_Name = NSStringFromClass([self class]);
    NSString *msg = [NSString stringWithFormat:@"!!! [%@.m] 文件中的 [%@] 方法不存在",class_Name,selector_Name];
    [GDAppCrashHandle noteErrorWithCustomMessage:msg];
}

- (void)avoidCrashForwardInvocation:(NSInvocation *)anInvocation {
    
    id target = nil;
    if ([self methodSignatureForSelector:[anInvocation selector]] ) {
        target = self;
        [anInvocation invokeWithTarget:target];
    } else {
        [self avoidCrashForwardInvocation:anInvocation];
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
