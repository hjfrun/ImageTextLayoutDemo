//
//  NSTextAttachment+Emotion.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/4/2.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "NSTextAttachment+Emotion.h"
#import <objc/runtime.h>

@implementation NSTextAttachment (Emotion)

- (Emotion *)emotion
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmotion:(Emotion *)emotion
{
    self.image = [UIImage imageNamed:emotion.png];
    objc_setAssociatedObject(self, @selector(emotion), emotion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
