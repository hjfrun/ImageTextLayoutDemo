//
//  EmotionLayout.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/4/4.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "EmotionLayout.h"

@interface EmotionLayout()

@property (nonatomic, strong) NSMutableArray *attriArray;
@property (nonatomic, assign) CGFloat itemWidth;

@end

@implementation EmotionLayout

- (NSMutableArray *)attriArray
{
    if (_attriArray == nil) {
        _attriArray = @[].mutableCopy;
    }
    return _attriArray;
}

- (instancetype)init
{
    return [self initWithMaxCols:7 maxRows:3];
}

- (instancetype)initWithMaxCols:(NSUInteger)maxCols maxRows:(NSUInteger)maxRows
{
    if (self = [super init]) {
        _maxCols = maxCols;
        _maxRows = maxRows;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemWidth = [UIScreen mainScreen].bounds.size.width / self.maxCols;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    [self.attriArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attriArray addObject:attrs];
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger emotionCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat contentWidth = self.collectionView.bounds.size.width * ((emotionCount - 1) / self.maxCols / self.maxRows + 1);
    CGFloat contentHeight = self.collectionView.bounds.size.height;
    
    return CGSizeMake(contentWidth, contentHeight);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attriArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger item = indexPath.item;
    
    if (item == [self.collectionView numberOfItemsInSection:0] - 1) {
        item = (item / self.maxRows / self.maxCols + 1) * self.maxCols * self.maxRows - 1;
    }
    
    NSInteger page = item / self.maxCols / self.maxRows;
    
    CGFloat attributesX = (item % self.maxCols) * self.itemWidth + page * self.itemWidth * self.maxCols;
    CGFloat attributesY = (item / self.maxCols) * self.itemWidth - page * self.itemWidth * self.maxRows;
    
    attributes.frame = CGRectMake(attributesX, attributesY, self.itemWidth, self.itemWidth);
    
    return attributes;
}

@end
