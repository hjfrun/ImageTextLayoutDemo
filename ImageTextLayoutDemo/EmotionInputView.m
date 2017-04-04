//
//  EmotionInputView.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/3/29.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "EmotionInputView.h"
#import "EmotionCell.h"
#import "EmotionManager.h"
#import "EmotionLayout.h"
#import "Emotion.h"

@interface EmotionInputView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *emotionCollectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *emotions;

@property (nonatomic, assign, readonly) NSInteger maxCols;
@property (nonatomic, assign, readonly) NSInteger maxRows;

@end

@implementation EmotionInputView

- (NSArray *)emotions
{
    if (_emotions == nil) {
        NSMutableArray *arrayM = @[].mutableCopy;
        NSArray *pureEmotions = [EmotionManager emotionList];
        Emotion *deleteEmotion = [Emotion new];
        deleteEmotion.png = @"emotion_delete";
        deleteEmotion.chs = @"";
        
        NSInteger emotionPageSize = self.maxRows * self.maxCols - 1;
        NSUInteger pageCount = pureEmotions.count / emotionPageSize;
        
        for (NSInteger i = 0; i < pageCount; i++) {
            [arrayM addObjectsFromArray:[pureEmotions subarrayWithRange:NSMakeRange(i * emotionPageSize, emotionPageSize)]];
            [arrayM addObject:deleteEmotion];
        }
        
        if (pureEmotions.count % emotionPageSize) {
            [arrayM addObjectsFromArray:[pureEmotions subarrayWithRange:NSMakeRange(pageCount * emotionPageSize, pureEmotions.count % emotionPageSize)]];
            [arrayM addObject:deleteEmotion];
        }
        _emotions = arrayM;
    }
    
    return _emotions;
}


+ (instancetype)emotionInputView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _maxCols = 7;
    _maxRows = 3;
    
    [self.emotionCollectionView registerNib:[UINib nibWithNibName:@"EmotionCell" bundle:nil] forCellWithReuseIdentifier:@"EmotionCell"];
    self.emotionCollectionView.backgroundColor = [UIColor lightGrayColor];
    self.emotionCollectionView.collectionViewLayout = [[EmotionLayout alloc] initWithMaxCols:self.maxCols maxRows:self.maxRows];
    self.emotionCollectionView.delegate = self;
    self.emotionCollectionView.dataSource = self;
    self.emotionCollectionView.pagingEnabled = YES;
    
    self.pageControl.numberOfPages = (self.emotions.count - 1) / self.maxCols / self.maxRows + 1;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (page != self.pageControl.currentPage) {
        self.pageControl.currentPage = page;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emotions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmotionCell *cell = (EmotionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"EmotionCell" forIndexPath:indexPath];
    cell.emotion = [self.emotions objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Emotion *emotion = [self.emotions objectAtIndex:indexPath.item];
    if (emotion.chs.length) {
        if (self.emotionClickedBlock) {
            self.emotionClickedBlock(emotion);
        }
    } else {
        if (self.deleteClickedBlock) {
            self.deleteClickedBlock();
        }
    }
}

@end
