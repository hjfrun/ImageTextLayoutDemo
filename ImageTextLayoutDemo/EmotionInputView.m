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

@interface EmotionInputView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *emotionCollectionView;

@end

@implementation EmotionInputView


+ (instancetype)emotionInputView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.emotionCollectionView registerNib:[UINib nibWithNibName:@"EmotionCell" bundle:nil] forCellWithReuseIdentifier:@"EmotionCell"];
    self.emotionCollectionView.backgroundColor = [UIColor lightGrayColor];
    self.emotionCollectionView.delegate = self;
    self.emotionCollectionView.dataSource = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [EmotionManager emotionList].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmotionCell *cell = (EmotionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"EmotionCell" forIndexPath:indexPath];
    cell.emotion = [[EmotionManager emotionList] objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Emotion *emotion = [[EmotionManager emotionList] objectAtIndex:indexPath.item];
    if (self.emotionClickedBlock) {
        self.emotionClickedBlock(emotion);
    }
}

@end
