//
//  EmotionLayout.h
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/4/4.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionLayout : UICollectionViewFlowLayout

@property (nonatomic, assign, readonly) NSUInteger maxCols;
@property (nonatomic, assign, readonly) NSUInteger maxRows;

- (instancetype)initWithMaxCols:(NSUInteger)maxCols maxRows:(NSUInteger)maxRows;

@end
