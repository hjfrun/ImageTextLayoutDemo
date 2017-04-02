//
//  ConvertViewController.m
//  ImageTextLayoutDemo
//
//  Created by HE Jianfeng on 2017/4/2.
//  Copyright © 2017年 hjfrun.com. All rights reserved.
//

#import "ConvertViewController.h"
#import "Emotion.h"
#import "EmotionManager.h"
#import "EmotionInputView.h"
#import "EmotionAttachment.h"

@interface ConvertViewController ()
@property (weak, nonatomic) IBOutlet UIButton *convert2TextButton;
@property (weak, nonatomic) IBOutlet UIButton *convert2EmotionButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) EmotionInputView *inputView;

@end

@implementation ConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.inputView = [EmotionInputView emotionInputView];
    __weak typeof(self) weakSelf = self;
    [self.inputView setEmotionClickedBlock:^(Emotion *emotion) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf insertTextView:strongSelf.textView withEmotion:emotion];
    }];
    
    self.textView.inputView = self.inputView;
    
    self.label.layer.borderColor = [UIColor greenColor].CGColor;
    self.label.layer.borderWidth = 1.f;
    
}

- (IBAction)convert2TextClicked:(UIButton *)sender {
    
    // 下面直接这样转是无法解析表情的
//    self.label.text = self.textView.attributedText.string;
    
    self.label.text = [self textFromAttributedText:self.textView.attributedText];
}


/**
 在把label内的[]表情转换为表情还是现实到label中
 */
- (IBAction)convert2EmotionClicked:(UIButton *)sender {

    self.label.attributedText = [self attributedTextFromText:self.label.text];
}


/**
 文本转换为带表情的属性文字

 @param text 纯文本
 */
- (NSAttributedString *)attributedTextFromText:(NSString *)text
{
    NSMutableAttributedString *attriStringM = [[NSMutableAttributedString alloc] init];
    
    NSString *emotionPattern = @"\\[\\w+\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emotionPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *resultsArray = [regex matchesInString:text options:kNilOptions range:NSMakeRange(0, text.length)];
    
    NSUInteger loc = 0;
    for (NSTextCheckingResult *result in resultsArray) {
        NSLog(@"range : %@", NSStringFromRange(result.range));
        
        NSUInteger length = result.range.location - loc;
        
        [attriStringM appendAttributedString:[[NSAttributedString alloc] initWithString:[text substringWithRange:NSMakeRange(loc, length)]]];
        
        NSString *chs = [text substringWithRange:result.range];
        
        [attriStringM appendAttributedString:[self emotionAttachWithChs:chs]];
        
        loc = result.range.location + result.range.length;
    }
    [attriStringM appendAttributedString:[[NSAttributedString alloc] initWithString:[text substringFromIndex:loc]]];
     
    return attriStringM;
}


/**
 根据匹配的[]的内容去返回表情属性文字

 @param chs  表情对应的描述字符
 @return 表情属性字符串
 */
- (NSAttributedString *)emotionAttachWithChs:(NSString *)chs
{
    Emotion *emotion = [EmotionManager emotionFromChs:chs];
    if (!emotion) {
        return [[NSAttributedString alloc] initWithString:chs];
    }
    EmotionAttachment *emotionAttach = [[EmotionAttachment alloc] init];
    emotionAttach.emotion = emotion;
    emotionAttach.bounds = CGRectMake(0, -5, self.label.font.lineHeight, self.label.font.lineHeight);
    return [NSAttributedString attributedStringWithAttachment:emotionAttach];
}

/**
 在这里把带表情的属性文字转换为文本

 @param attriString 带表情的属性文字
 @return 纯文本
 */
- (NSString *)textFromAttributedText:(NSAttributedString *)attriString
{
    NSMutableString *resultString = [NSMutableString string];
    [attriString enumerateAttributesInRange:NSMakeRange(0, attriString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        id obj = attrs[@"NSAttachment"];
        if (!obj) {
            [resultString appendString:[attriString attributedSubstringFromRange:range].string];
        } else {
            EmotionAttachment *emotionAttach = (EmotionAttachment *)obj;
            [resultString appendString:emotionAttach.emotion.chs];
        }
    }];
    
    return resultString;
}

- (void)insertTextView:(UITextView *)textView withEmotion:(Emotion *)emotion
{
    EmotionAttachment *emotionAttach = [[EmotionAttachment alloc] init];
    emotionAttach.emotion = emotion;
    emotionAttach.bounds = CGRectMake(0, -5, 20, 20);

    NSAttributedString *attriStr = [NSAttributedString attributedStringWithAttachment:emotionAttach];
    
    NSMutableAttributedString *attriStrM = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    
    NSUInteger loc = textView.selectedRange.location;
    
    [attriStrM insertAttributedString:attriStr atIndex:loc];
    
    textView.attributedText = attriStrM;
    textView.selectedRange = NSMakeRange(loc + 1, 0);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
