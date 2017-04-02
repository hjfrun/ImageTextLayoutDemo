//
//  EmotionAttachment.h
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/4/2.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emotion.h"

@interface EmotionAttachment : NSTextAttachment

@property (nonatomic, strong) Emotion *emotion;

@end
