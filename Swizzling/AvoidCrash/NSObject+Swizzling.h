//
//  NSObject+Swizzling.h
//  Swizzling
//
//  Created by moqing on 2018/2/8.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end
