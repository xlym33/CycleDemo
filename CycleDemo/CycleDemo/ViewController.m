//
//  ViewController.m
//  CycleDemo
//
//  Created by huangshan on 16/9/7.
//  Copyright © 2016年 huangshan. All rights reserved.
//

#import "ViewController.h"

#import "HSCycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HSCycleView *cycleView = [[HSCycleView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 250.0f) imageURLArray:@[@"1",@"2",@"3"] selectBlock:^(NSInteger index, NSString *imageURL) {
        
        NSLog(@"~~~~~~~~~~~~~~~~%ld", index);
        
    } scrollBlock:^(NSInteger index) {
        
    }];
    
    
    [self.view addSubview:cycleView];

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        cycleView.imageURLArray = @[@"1",@"2"];
//
//    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
