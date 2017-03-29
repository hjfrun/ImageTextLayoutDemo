//
//  Emotion.h
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/3/29.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emotion : NSObject

@property (nonatomic, copy) NSString *chs;
@property (nonatomic, copy) NSString *png;

+ (instancetype)emotionWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
