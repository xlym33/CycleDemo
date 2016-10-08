# CycleDemo

HSCycleView是轮播图

使用教程：

```
    HSCycleView *cycleView = [[HSCycleView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 250.0f) imageURLArray:@[@"1",@"2",@"3"] selectBlock:^(NSInteger index, NSString *imageURL) {
        
        //点击了哪个item
        NSLog(@"点击了~~~~~~~~~~~~~~~~%ld", index);
        
    } scrollBlock:^(NSInteger index) {
        
        //滑动到了哪个item
        
        NSLog(@"滑动到了~~~~~~~~~~~~~~~~%ld", index);

    }];
    
    
    [self.view addSubview:cycleView];
```