//
//  ViewController.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/3/29.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "ViewController.h"
#import "EmotionManager.h"
#import "EmotionInputView.h"
#import "Emotion.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) EmotionInputView *inputView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.inputView = [EmotionInputView emotionInputView];
    __weak typeof(self) weakSelf = self;
    [self.inputView setEmotionClickedBlock:^(Emotion *emotion) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        [strongSelf insertTextView:strongSelf.textView withEmotion:emotion];
    }];
    
    [self.inputView setDeleteClickedBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.textView deleteBackward];
    }];
    
    self.textView.inputView = self.inputView;
}

- (void)insertTextView:(UITextView *)textView withEmotion:(Emotion *)emotion
{
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:emotion.png];
    attach.bounds = CGRectMake(0, -5, 20, 20);
    NSAttributedString *attriStr = [NSAttributedString attributedStringWithAttachment:attach];

    NSMutableAttributedString *attriStrM = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    
    NSUInteger loc = textView.selectedRange.location;
    
    [attriStrM insertAttributedString:attriStr atIndex:loc];
    
    textView.attributedText = attriStrM;
    textView.selectedRange = NSMakeRange(loc + 1, 0);
}

- (void)setupLabel
{
    NSMutableAttributedString *attriStringM = [[NSMutableAttributedString alloc] initWithString:@"Hello World"];
    
    UIImage *avatarImage = [UIImage imageNamed:@"avatar.jpg"];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = avatarImage;
    attachment.bounds = CGRectMake(0, -10, 30, 30);
    
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
    [attriStringM appendAttributedString:attributedString];
    
    self.label.attributedText = attriStringM;
    
    self.label.layer.borderColor = [UIColor greenColor].CGColor;
    self.label.layer.borderWidth = 1.f;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
