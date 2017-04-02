//
//  Emotion.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/3/29.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "Emotion.h"

@implementation Emotion

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
//        [self setValuesForKeysWithDictionary:dict];
        self.chs = dict[@"chs"];
        self.png = dict[@"png"];
    }
    return self;
}


+ (instancetype)emotionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
