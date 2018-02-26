//
//  NSString+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/26.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSString+Swizzling.h"
#import "GDAppCrashHandle.h"


@implementation NSString (Swizzling)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class stringClass = NSClassFromString(@"__NSCFConstantString");

        //characterAtIndex
        [stringClass swizzleSelector:@selector(characterAtIndex:) withSwizzledSelector:@selector(avoidCrashCharacterAtIndex:)];
        
        //substringFromIndex
        [stringClass swizzleSelector:@selector(substringFromIndex:) withSwizzledSelector:@selector(avoidCrashSubstringFromIndex:)];
        
        //substringToIndex
        [stringClass swizzleSelector:@selector(substringToIndex:) withSwizzledSelector:@selector(avoidCrashSubstringToIndex:)];
        
        //substringWithRange:
        [stringClass swizzleSelector:@selector(substringWithRange:) withSwizzledSelector:@selector(avoidCrashSubstringWithRange:)];
        
        //stringByReplacingOccurrencesOfString:withString:
        [stringClass swizzleSelector:@selector(stringByReplacingOccurrencesOfString:withString:) withSwizzledSelector:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:)];
        
        //stringByReplacingOccurrencesOfString:withString:options:range:
        [stringClass swizzleSelector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSwizzledSelector:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:options:range:)];

        //stringByReplacingCharactersInRange:withString:
        [stringClass swizzleSelector:@selector(stringByReplacingCharactersInRange:withString:) withSwizzledSelector:@selector(avoidCrashStringByReplacingCharactersInRange:withString:)];

    });
}

//=================================================================
//                           characterAtIndex:
//=================================================================
#pragma mark - characterAtIndex:

- (unichar)avoidCrashCharacterAtIndex:(NSUInteger)index {
    
    unichar characteristic;
    @try {
        characteristic = [self avoidCrashCharacterAtIndex:index];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"AvoidCrash default is to return a without assign unichar.";
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return characteristic;
    }
}

//=================================================================
//                           substringFromIndex:
//=================================================================
#pragma mark - substringFromIndex:

- (NSString *)avoidCrashSubstringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringFromIndex:from];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

//=================================================================
//                           substringToIndex
//=================================================================
#pragma mark - substringToIndex

- (NSString *)avoidCrashSubstringToIndex:(NSUInteger)to {
    
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringToIndex:to];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    }
    @finally {
        return subString;
    }
}


//=================================================================
//                           substringWithRange:
//=================================================================
#pragma mark - substringWithRange:

- (NSString *)avoidCrashSubstringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringWithRange:range];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

//=================================================================
//                stringByReplacingOccurrencesOfString:
//=================================================================
#pragma mark - stringByReplacingOccurrencesOfString:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

//=================================================================
//  stringByReplacingOccurrencesOfString:withString:options:range:
//=================================================================
#pragma mark - stringByReplacingOccurrencesOfString:withString:options:range:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


//=================================================================
//       stringByReplacingCharactersInRange:withString:
//=================================================================
#pragma mark - stringByReplacingCharactersInRange:withString:

- (NSString *)avoidCrashStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [GDAppCrashHandle noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

@end
