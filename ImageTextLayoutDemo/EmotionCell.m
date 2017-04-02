//
//  EmotionCell.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/3/29.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "EmotionCell.h"
#import "Emotion.h"

@interface EmotionCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation EmotionCell

- (void)setEmotion:(Emotion *)emotion
{
    _emotion = emotion;
    
    self.imageView.image = [UIImage imageNamed:emotion.png];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
