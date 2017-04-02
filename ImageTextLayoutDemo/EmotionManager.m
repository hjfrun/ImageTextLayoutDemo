//
//  EmotionManager.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/3/29.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "EmotionManager.h"
#import "Emotion.h"


static NSArray *_emotions;

@implementation EmotionManager

+ (NSArray *)emotionList
{
    NSMutableArray *emotionM = @[].mutableCopy;
    
    if (_emotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in dictArray) {
            Emotion *emotion = [Emotion emotionWithDict:dict];
            [emotionM addObject:emotion];
        }
        _emotions = emotionM.copy;
    }
    return _emotions;
}

+ (Emotion *)emotionFromChs:(NSString *)chs
{
    for (Emotion *emotion in _emotions) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    return nil;
}

@end
