//
//  CycleView.m
//  CycleDemo
//
//  Created by huangshan on 16/9/7.
//  Copyright © 2016年 huangshan. All rights reserved.
//

#import "HSCycleView.h"


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
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageView.clipsToBounds = YES;
    
    [self addSubview:self.imageView];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setImageURL:(NSString *)imageURL {
    
    if (_imageURL != imageURL){
        
        _imageURL = imageURL;
    }
    
        self.imageView.image = [UIImage imageNamed:imageURL];
        
}


@end


#pragma mark =====================HSCycleView

@interface HSCycleView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger currenIndex;

@property (nonatomic, strong) HSCycleItemView *preContainView;

@property (nonatomic, strong) HSCycleItemView *currentContainView;

@property (nonatomic, strong) HSCycleItemView *nextContainView;

@property (nonatomic, assign) NSInteger numOfItem;


@end

@implementation HSCycleView


- (instancetype)initWithFrame:(CGRect)frame imageURLArray:(NSArray *)array selectBlock:(void(^)(NSInteger, NSString *))selectBlock scrollBlock:(void(^)(NSInteger))scrollBlock {
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化数据
        
        [self initData];
        
        //初始化子视图
        
        [self initSubview];
        
        //设置自动布局
        
        [self configAutoLayout];
        
        //设置主题模式
        
        [self configTheme];
        
        self.selectBlock = selectBlock;
        
        self.scrollBlock = scrollBlock;
        
        self.imageURLArray = array;
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化数据
        
        [self initData];
        
        //初始化子视图
        
        [self initSubview];
        
        //设置自动布局
        
        [self configAutoLayout];
        
        //设置主题模式
        
        [self configTheme];
        
    }
    return self;
}

- (void)initData {
    
    //循环
    self.isCycle = YES;
}

- (void)initSubview {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    _scrollView.backgroundColor = [UIColor clearColor];
    
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.delegate = self;
    
    _scrollView.bounces = NO;
    
    _scrollView.directionalLockEnabled = YES;
    
    _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    
    _scrollView.pagingEnabled = YES;
    
    [self addSubview:_scrollView];
}

- (void)configAutoLayout {
    
    
}

- (void)configTheme {
    
    
}

#pragma mark - Method

- (void)setImageURLArray:(NSArray *)imageURLArray {
    
    if (_imageURLArray != imageURLArray){
        
        _imageURLArray = imageURLArray;
    }
    
    if (imageURLArray.count){
    
        self.currenIndex = 0;
    }
    
    if (imageURLArray.count == 1){
        
        self.scrollView.scrollEnabled = NO;
    }
    else {
        
        self.scrollView.scrollEnabled = YES;
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
    self.nextContainView.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * 2, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    self.currentContainView.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    self.preContainView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    [self changeContainViewImageURLSelectIndex:self.currenIndex];
    
}

#pragma mark - 设置当前的index

-(void)setCurrenIndex:(NSInteger)currenIndex
{
    if (_currenIndex != currenIndex){
        
        _currenIndex = currenIndex;
    }
    
    [self changeContainViewImageURLSelectIndex:currenIndex];
    
    if (self.scrollBlock){
        
        self.scrollBlock(currenIndex);
    }
}

-(void)changeContainViewImageURLSelectIndex:(NSInteger)index
{
    
    if (self.imageURLArray.count){
        
        NSInteger preIndex = [self getPreIndex:index];
        
        NSInteger nextIndex = [self getNextIndex:index];
        
        
        if (index == 0 && self.isCycle == NO){
            
            //不循环且是第一个item时候
            self.scrollView.contentSize = CGSizeMake(2 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
            
            self.preContainView.imageURL = self.imageURLArray[index];
            
            self.currentContainView.imageURL = self.imageURLArray[nextIndex];
            
            self.scrollView.contentOffset = CGPointMake(0, 0);
            
        }
        else if (index == self.numOfItem - 1 && self.isCycle == NO){
            
            //不循环且是最后一个item的时候
            self.scrollView.contentSize = CGSizeMake(2 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
            
            self.preContainView.imageURL = self.imageURLArray[preIndex];
            
            self.currentContainView.imageURL = self.imageURLArray[index];
            
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        }
        else {
            
            //其他情况
            self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
            
            self.preContainView.imageURL = self.imageURLArray[preIndex];
            
            self.nextContainView.imageURL = self.imageURLArray[nextIndex];
            
            self.currentContainView.imageURL = self.imageURLArray[index];
            
            //获取选中的下标 并设置内容视图相应的页面显示
            
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
            
        }
        
    }
}

#pragma mark - 滑动视图滑动结束处理

- (void)scrollViewDidEndScrollingHandle{
    
    NSInteger page = self.scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame);
    
    //判断左滑动还是右滑动
    
    switch (page) {
            
        case 0:
            
            [self playLastContainView];
            
            break;
            
        case 1:
            
            //当不循环的时候，且是第一个item的时候，播放下一个item
            if (self.currenIndex == 0 && self.isCycle == NO){
                
                [self playNextContainView];
            }
            
            break;
            
        case 2:
            
            [self playNextContainView];
            
            break;
            
        default:
            break;
    }
}



#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    
}

//滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingHandle];
    
}

//当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingHandle];
    
}

#pragma mark - 上一张

-(NSInteger)getPreIndex:(NSInteger)index
{
    if (index == 0){
        
        if (self.isCycle){
            
            //循环
            return self.numOfItem - 1;
            
        }
        else {
            
            //不循环
            return 0;
        }
    }
    
    return index - 1;
    
}

- (void)playLastContainView
{
    self.currenIndex = [self getPreIndex:self.currenIndex];
}

#pragma mark - 下一张

- (void)playNextContainView
{
    self.currenIndex = [self getNextIndex:self.currenIndex];
}

-(NSInteger)getNextIndex:(NSInteger)index
{
    if (index == self.numOfItem - 1){
        
        if (self.isCycle){
            
            return 0;
            
        }
        else {
            
            return self.numOfItem - 1;
        }
    }
    
    return index + 1;
    
}

#pragma mark - Lazy Loading

-(NSInteger)numOfItem
{
    //先判断代理是否存在 并且 是否实现了方法
    
    _numOfItem = self.imageURLArray.count;
    
    return _numOfItem;
}

-(HSCycleItemView *)preContainView
{
    if (_preContainView == nil){
        
        _preContainView = [[HSCycleItemView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        
        [self.scrollView addSubview:_preContainView];
    }
    
    return _preContainView;
}

-(HSCycleItemView *)currentContainView
{
    if (_currentContainView == nil){
        
        _currentContainView = [[HSCycleItemView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        
        [_currentContainView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(currentItemClick)]];
        
        [self.scrollView addSubview:_currentContainView];
    }
    
    return _currentContainView;
}

-(HSCycleItemView *)nextContainView
{
    if (_nextContainView == nil){
        
        _nextContainView = [[HSCycleItemView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame) * 2, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        
        [self.scrollView addSubview:_nextContainView];
    }
    
    return _nextContainView;
}

- (void)currentItemClick {
    
    if (self.imageURLArray){
        
        NSString *imageURL = self.imageURLArray[self.currenIndex];
        
        if (self.selectBlock){
            
            self.selectBlock(self.currenIndex, imageURL);
        }
    }
}




@end
