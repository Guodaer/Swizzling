//
//  NSMutableAttributedString+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/26.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSMutableAttributedString+Swizzling.h"
#import "GDAppCrashHandle.h"
@implementation NSMutableAttributedString (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
        
        //initWithString:
        [NSConcreteMutableAttributedString swizzleSelector:@selector(initWithString:) withSwizzledSelector:@selector(avoidCrashInitWithString:)];
        
        
        //initWithString:attributes:
        [NSConcreteMutableAttributedString swizzleSelector:@selector(initWithString:attributes:) withSwizzledSelector:@selector(avoidCrashInitWithString:attributes:)];

    });
}

//=================================================================
//                          initWithString:
//=================================================================
#pragma mark - initWithString:


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
//                     initWithString:attributes:
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
