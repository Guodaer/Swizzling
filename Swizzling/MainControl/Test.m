//
//  Test.m
//  Swizzling
//
//  Created by moqing on 2018/2/27.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "Test.h"

@implementation Test

- (int)age {
    if (_age) {
        return _age;
    }else {
        return 18;
    }
}

@end
