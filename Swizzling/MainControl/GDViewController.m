//
//  GDViewController.m
//  Swizzling
//
//  Created by moqing on 2018/2/8.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "GDViewController.h"
#import <objc/runtime.h>
#import "GDAppCrashHandle.h"
#import "Test.h"
@interface GDViewController ()

@end

@implementation GDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSString *str = nil;
//    NSArray *arr = @[@"000",@"111",@"222",str];
//    [arr objectAtIndex:10];
//    NSMutableArray *array = [arr mutableCopy];
//    [array addObject:str];
//    [array insertObject:@"1" atIndex:10];
//    NSLog(@"%@",array);
    
//    [self class_copyMethodList:objc_getClass("__NSPlaceholderDictionary")];
//    [self class_copyMethodList:[NSDictionary class]];
    
//    NSDictionary *dic = @{@"1":str};
//    NSMutableDictionary *md = [NSMutableDictionary dictionary];
//    [md setObject:@"1" forKey:@"1"];
//    [md setObject:@"2" forKey:@"2"];
//    [md removeObjectForKey:str];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 100, 30);
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nihao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    Test *test1 =[[Test alloc] init];
    test1.name = @"one";
    test1.age = 16;
    
    Test *test2 =[[Test alloc] init];
    test2.name = @"one";
//    test2.age = 16;

    NSLog(@"%d",test2.age);
    test2.age = 11;
    NSLog(@"%d",test2.age);
    
    
    if ([test1 isEqual:test2]) {
        NSLog(@"11111111111");
    }else {
        NSLog(@"22222222222");
    }
}


- (void)nihao:(UIButton*)sender {
    
    GDAppCrashHandle *gd = [[GDAppCrashHandle alloc] init];
    [gd performSelector:@selector(woqu) withObject:nil afterDelay:0];
    
}

- (void)class_copyMethodList:(Class)class {
    unsigned int count;
    Method *ml = class_copyMethodList(class, &count);
    for (int i=0; i<count; i++) {
        Method method = ml[i];
        NSLog(@"%s %s",__func__,sel_getName(method_getName(method)));
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
