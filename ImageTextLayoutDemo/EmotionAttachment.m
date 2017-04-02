//
//  EmotionAttachment.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/4/2.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "EmotionAttachment.h"

@implementation EmotionAttachment

- (void)setEmotion:(Emotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}

@end
