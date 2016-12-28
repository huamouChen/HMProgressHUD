//
//  HMTextOnlyHUD.m
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import "HMTextOnlyHUD.h"
#import "HMPrivateHUDdProtocol.h"

#define kPadding 68.0f
#define kMargin 10.0f
#define kHeight 45.0f

#define KScreenWidth     [UIScreen mainScreen].bounds.size.width
#define KScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface HMTextOnlyHUD ()<HMPrivateHUDdProtocol>

/**
 Label
 */
@property (strong, nonatomic) UILabel *label;
@end

@implementation HMTextOnlyHUD

#pragma mark - 构造方法
- (instancetype)init {
    if (self = [super init]) {
        [self setupAppearance];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAppearance];
    }
    return self;
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    self.label.frame = self.bounds;
}


#pragma mark - 设置外观
- (void)setupAppearance {
    // 1. 添加控件
    [self addSubview:self.label];
    // 设置背景颜色
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    // 圆角
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
}

#pragma mark - setter && getter
- (void)setText:(NSString *)text {
    _text = text;
    _label.text = text;
    
    // 计算文字真实宽度
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(KScreenWidth * 0.65, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
    
    CGRect frame = self.frame;
    frame.size.width = KScreenWidth * 0.65;
    frame.origin.x = (KScreenWidth - frame.size.width) / 2.0;
    frame.origin.y = (KScreenHeight - frame.size.height) / 2.0;
    frame.size.height = textRect.size.height + 3 * kMargin < kHeight ? kHeight : textRect.size.height + 3 * kMargin;
    
    self.frame = frame;
    [self layoutIfNeeded];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label.textColor = textColor;
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    _label.font = [UIFont boldSystemFontOfSize:fontSize];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        // 居中
        _label.textAlignment = NSTextAlignmentCenter;
        // 颜色
        _label.textColor = [UIColor whiteColor];
        // 换行
        _label.numberOfLines = 0;
        // 字体大小
        _label.font = [UIFont boldSystemFontOfSize:15.0];
    }
    return _label;
}

@end
