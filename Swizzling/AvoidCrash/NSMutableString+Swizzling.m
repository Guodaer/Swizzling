//
//  NSMutableString+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/26.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSMutableString+Swizzling.h"
#import "GDAppCrashHandle.h"
@implementation NSMutableString (Swizzling)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class stringClass = NSClassFromString(@"__NSCFString");

        //replaceCharactersInRange
        [stringClass swizzleSelector:@selector(replaceCharactersInRange:withString:) withSwizzledSelector:@selector(avoidCrashReplaceCharactersInRange:withString:)];
        
        //insertString:atIndex:
        [stringClass swizzleSelector:@selector(insertString:atIndex:) withSwizzledSelector:@selector(avoidCrashInsertString:atIndex:)];
        
        //deleteCharactersInRange
        [stringClass swizzleSelector:@selector(deleteCharactersInRange:) withSwizzledSelector:@selector(avoidCrashDeleteCharactersInRange:)];
    });
}

//=================================================================
//                     replaceCharactersInRange
//=================================================================
#pragma mark - replaceCharactersInRange

- (void)avoidCrashReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    @try {
        [self avoidCrashReplaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                     insertString:atIndex:
//=================================================================
#pragma mark - insertString:atIndex:

- (void)avoidCrashInsertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    @try {
        [self avoidCrashInsertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                   deleteCharactersInRange
//=================================================================
#pragma mark - deleteCharactersInRange

- (void)avoidCrashDeleteCharactersInRange:(NSRange)range {
    
    @try {
        [self avoidCrashDeleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

@end
