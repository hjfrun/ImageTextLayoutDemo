//
//  EmotionInputView.h
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/3/29.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emotion;

@interface EmotionInputView : UIView

@property (nonatomic, strong) void (^emotionClickedBlock)(Emotion *emotion);
@property (nonatomic, strong) void (^deleteClickedBlock)();

+ (instancetype)emotionInputView;

@end
