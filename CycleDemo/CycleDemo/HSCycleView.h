//
//  CycleView.h
//  CycleDemo
//
//  Created by huangshan on 16/9/7.
//  Copyright © 2016年 huangshan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HSCycleItemView : UIView

@property (nonatomic, strong) NSString *imageURL;

@end


@interface HSCycleView : UIView

/** 是否循环播放，默认YES */
@property (nonatomic, assign) BOOL isCycle;

@property (nonatomic, strong) NSArray *imageURLArray;

@property (nonatomic, copy) void (^selectBlock)(NSInteger, NSString *);

@property (nonatomic, copy) void (^scrollBlock)(NSInteger);

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame imageURLArray:(NSArray *)array selectBlock:(void(^)(NSInteger, NSString *))selectBlock scrollBlock:(void(^)(NSInteger))scrollBlock;


@end
