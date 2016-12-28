//
//  HMProgressHUDView.m
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import "HMProgressHUDView.h"
#import "HMPrivateHUDdProtocol.h"

static const CGFloat padding = 5.0f;
static const CGFloat indicatorHeight = 50.0f;

@interface HMProgressHUDView ()<HMPrivateHUDdProtocol>{
    CGSize _textSize;
}

/**
 菊花
 */
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

/**
 Label
 */
@property (strong, nonatomic) UILabel *label;
@end

@implementation HMProgressHUDView

#pragma mark - 构造函数
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

- (void)setupAppearance {
    [self addSubview:self.indicatorView];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.layer.cornerRadius = 8.0f;
    self.layer.masksToBounds = YES;
    _textSize = CGSizeZero;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.label.text) {
        CGRect indicatorFrame = CGRectZero;
        indicatorFrame.origin.x = (self.bounds.size.width - indicatorHeight) / 2.0;
        indicatorFrame.origin.y = padding;
        indicatorFrame.size = CGSizeMake(indicatorHeight, indicatorHeight);
        self.indicatorView.frame = indicatorFrame;
        
        CGRect labelFrame = CGRectZero;
        labelFrame.origin.x = (self.bounds.size.width - _textSize.width) / 2.0;
        labelFrame.origin.y = CGRectGetMaxY(self.indicatorView.frame) + padding;
        labelFrame.size = _textSize;
        self.label.frame = labelFrame;
    }
    else {
        self.indicatorView.frame = self.bounds;
    }
}

- (void)setText:(NSString *)text {
    if (text && ![text isEqualToString:@""]) {
        self.label.text = text;
        [self addSubview:_label];
        
        CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 100.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGRect frame = self.frame;
        frame.size.width = textRect.size.width + 4 * padding;
        if (frame.size.width > screenWidth) {
            frame.size.width = screenWidth - 4 * padding;
        }
        _textSize = textRect.size;
        frame.size.width = MAX(frame.size.width, indicatorHeight);
        frame.size.height = textRect.size.height + indicatorHeight + 4 * padding;
        frame.size.width = MAX(frame.size.height, frame.size.width);
        self.frame = frame;
    }
    else {
        self.frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    }
    [self layoutIfNeeded];
    
}

- (void)startAnimation {
    [self.indicatorView startAnimating];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.indicatorView.color = indicatorColor;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.color = [UIColor whiteColor];
        _indicatorView = indicatorView;
    }
    
    return _indicatorView;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.font = [UIFont boldSystemFontOfSize:15.0];
        _label = label;
    }
    return _label;
}

@end
