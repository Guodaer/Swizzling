//
//  NSArray+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/24.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import "GDAppCrashHandle.h"
@implementation NSArray (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        [__NSArrayI swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(__NSArrayIAvoidCrashObjectAtIndex:)];
        
        [__NSSingleObjectArrayI swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(__NSSingleObjectArrayIAvoidCrashObjectAtIndex:)];

        [__NSArray0 swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(__NSArray0AvoidCrashObjectAtIndex:)];

        if (AvoidCrashIsiOS(11.0)) {
            [__NSArrayI swizzleSelector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(__NSArrayIAvoidCrashObjectAtIndexedSubscript:)];
        }
        
        //getObjects:range:
        [__NSArray swizzleSelector:@selector(getObjects:range:) withSwizzledSelector:@selector(NSArrayAvoidCrashGetObjects:range:)];
        [__NSSingleObjectArrayI swizzleSelector:@selector(getObjects:range:) withSwizzledSelector:@selector(__NSSingleObjectArrayIAvoidCrashGetObjects:range:)];
        [__NSArrayI swizzleSelector:@selector(getObjects:range:) withSwizzledSelector:@selector(__NSArrayIAvoidCrashGetObjects:range:)];
        
    });
}

//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)__NSArrayIAvoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
    
}
#pragma mark - objectAtIndex:

//__NSArrayI  objectAtIndex:
- (id)__NSArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

//__NSSingleObjectArrayI objectAtIndex:
- (id)__NSSingleObjectArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSSingleObjectArrayIAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}
//__NSArray0 objectAtIndex:
- (id)__NSArray0AvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSArray0AvoidCrashObjectAtIndex:index];
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
//                           getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

//NSArray getObjects:range:
- (void)NSArrayAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self NSArrayAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSSingleObjectArrayI  getObjects:range:
- (void)__NSSingleObjectArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self __NSSingleObjectArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSArrayI  getObjects:range:
- (void)__NSArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self __NSArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}
@end
