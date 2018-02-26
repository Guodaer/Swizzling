//
//  NSObject+Swizzling.m
//  Swizzling
//
//  Created by moqing on 2018/2/8.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSObject (Swizzling)

/**
 交换类方法

 @param originalSelector 系统原始方法
 @param swizzledSelector 处理过的方法
 */
+ (void)swizzle_Class_Selector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


/**
 交换实例方法

 @param originalSelector 原方法
 @param swizzledSelector 处理过的方法
 */
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector {
    
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    //若已存在，则添加失败
    BOOL didAddMethod = class_addMethod(class, originalSelector,
                        method_getImplementation(swizzledMethod),//获取方法实现
                        method_getTypeEncoding(swizzledMethod));//获取方法实现的返回值
    //若原来的方法并不存在则添加
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
//    因为方法可能不是在这个类里，可能是在其父类中才有实现，因此先尝试添加方法的实现，若添加成功了，则直接替换一下实现即可。若添加失败了，说明已经存在这个方法实现了，则只需要交换这两个方法的实现就可以了。
    /*
    尽量使用method_exchangeImplementations函数来交换，因为它是原子操作的，线程安全。尽量不要自己手动写这样的代码：
    
    IMP imp1 = method_getImplementation(m1);
    IMP imp2 = method_getImplementation(m2);
    method_setImplementation(m1, imp2);
    method_setImplementation(m2, imp1);
     虽然method_exchangeImplementations函数的本质也是这么写法，但是它内部做了线程安全处理。
     

     */
    /*
     简单使用swizzling
     
     最简单的方法实现交换如下：
     
     Method originalMethod = class_getInstanceMethod([NSArray class], @selector(lastObject));
     Method newMedthod = class_getInstanceMethod([NSArray class], NSSelectorFromString(@"safeLastObject"));
     method_exchangeImplementations(originalMethod, newMedthod);
     
     // NSArray提供了这样的实现
     - (id) safeLastObject {
     if (self.count == 0) {
     NSLog(@"%s 数组为空，直接返回nil", __FUNCTION__);
     return nil;
     }
     return [self safeLastObject];
     }
     看到safeLastObject这个方法递归调用自己了吗？为什么不是调用return [self safeLastObject]？因为我们交换了方法的实现，那么系统在调用safeLastObject方法是，找的是safeLastObject方法的实现，而手动调用safeLastObject方法时，会调用safeLastObject方法的实现。不清楚？回到前面看一看那个交换IMP的图吧！
     
     我们通过使用swizzling只是为了添加个打印？当然不是，我们还可以做很多事的。比如，上面我们还做了防崩溃处理。
     */
}



#if 0
 //判断类中是否包含某个方法的实现
 BOOL class_respondsToSelector(Class cls, SEL sel)
 //获取类中的方法列表
 Method *class_copyMethodList(Class cls, unsigned int *outCount)
 //为类添加新的方法,如果方法该方法已存在则返回NO
 BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
 //替换类中已有方法的实现,如果该方法不存在添加该方法
 IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types)
 //获取类中的某个实例方法(减号方法)
 Method class_getInstanceMethod(Class cls, SEL name)
 //获取类中的某个类方法(加号方法)
 Method class_getClassMethod(Class cls, SEL name)
 //获取类中的方法实现
 IMP class_getMethodImplementation(Class cls, SEL name)
 //获取类中的方法的实现,该方法的返回值类型为struct
 IMP class_getMethodImplementation_stret(Class cls, SEL name)
 
 //获取Method中的SEL
 SEL method_getName(Method m)
 //获取Method中的IMP
 IMP method_getImplementation(Method m)
 //获取方法的Type字符串(包含参数类型和返回值类型)
 const char *method_getTypeEncoding(Method m)
 //获取参数个数
 unsigned int method_getNumberOfArguments(Method m)
 //获取返回值类型字符串
 char *method_copyReturnType(Method m)
 //获取方法中第n个参数的Type
 char *method_copyArgumentType(Method m, unsigned int index)
 //获取Method的描述
 struct objc_method_description *method_getDescription(Method m)
 //设置Method的IMP
 IMP method_setImplementation(Method m, IMP imp)
 //替换Method
 void method_exchangeImplementations(Method m1, Method m2)
 
 //获取SEL的名称
 const char *sel_getName(SEL sel)
 //注册一个SEL
 SEL sel_registerName(const char *str)
 //判断两个SEL对象是否相同
 BOOL sel_isEqual(SEL lhs, SEL rhs)
 
 //通过块创建函数指针,block的形式为^ReturnType(id self,参数,...)
 IMP imp_implementationWithBlock(id block)
 //获取IMP中的block
 id imp_getBlock(IMP anImp)
 //移出IMP中的block
 BOOL imp_removeBlock(IMP anImp)
 
 //调用target对象的sel方法
 id objc_msgSend(id target, SEL sel, 参数列表...)
 
#endif

@end
