//
//  GDViewController.m
//  Swizzling
//
//  Created by moqing on 2018/2/8.
//  Copyright © 2018年 guoda. All rights reserved.
//

#import "GDViewController.h"
#import <objc/runtime.h>
@interface GDViewController ()

@end

@implementation GDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str = nil;
    NSArray *arr = @[str,@"000",str,@"111",@"222",str];
    NSMutableArray *array = [arr copy];
    NSLog(@"%@",array);
    
//    [self class_copyMethodList:objc_getClass("__NSArrayM")];
//    [self class_copyMethodList:[NSMutableArray class]];
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
