//
//  HSCycleItemView.m
//  CycleDemo
//
//  Created by huangshan on 16/9/7.
//  Copyright © 2016年 huangshan. All rights reserved.
//

#import "HSCycleItemView.h"

@interface HSCycleItemView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HSCycleItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化数据
        
        [self initData];
        
        //初始化子视图
        
        [self initSubview];
        
    }
    return self;
}


- (void)initData {
    
}

- (void)initSubview {
 
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    [self addSubview:self.imageView];
}

- (void)setImageURL:(NSString *)imageURL {

    if (_imageURL != imageURL){
    
        _imageURL = imageURL;
    }
    
    self.imageView.image = [UIImage imageNamed:imageURL];
}


@end
