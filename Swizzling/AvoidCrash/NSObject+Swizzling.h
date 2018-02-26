//
//  NSObject+Swizzling.h
//  Swizzling
//
//  Created by moqing on 2018/2/8.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

/**
 交换实例方法
 
 @param originalSelector 原方法
 @param swizzledSelector 处理过的方法
 */
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

/**
 交换类方法
 
 @param originalSelector 系统原始方法
 @param swizzledSelector 处理过的方法
 */
+ (void)swizzle_Class_Selector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end
