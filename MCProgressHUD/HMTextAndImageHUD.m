//
//  HMTextAndImageHUD.m
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import "HMTextAndImageHUD.h"
#import "HMPrivateHUDdProtocol.h"

static const CGFloat padding = 10.0f;

@interface HMTextAndImageHUD ()<HMPrivateHUDdProtocol> {
    CGSize _imageSize;
    CGSize _textSize;
}

/**
 图片
 */
@property (strong, nonatomic) UIImageView *imageView;

/**
 Label
 */
@property (strong, nonatomic) UILabel *label;
@end

@implementation HMTextAndImageHUD

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

- (void)setupAppearance {
    [self addSubview:self.label];
    [self addSubview:self.imageView];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    _imageSize = CGSizeZero;
    _textSize = CGSizeZero;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.frame.size.width - _imageSize.width) / 2.0, padding, _imageSize.width, _imageSize.height);
    self.label.frame = CGRectMake(0, _imageSize.height + 2 * padding, self.frame.size.width, _textSize.height);
}

#pragma mark - setter && getter
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label.textColor = textColor;
}

- (void)setText:(NSString *)text andImage:(UIImage *)image {
    self.label.text = text;
    self.imageView.image = image;
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 100.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = self.frame;
    CGFloat tempWidth = MAX(textRect.size.width, image.size.width);
    frame.size.width = tempWidth + 2 * padding;
    if (frame.size.width > screenWidth) {
        frame.size.width = screenWidth - 2 * padding;
    }
    
    frame.origin.x = (screenWidth - frame.size.width) / 2.0;
    frame.size.height = textRect.size.height + image.size.height + 3 * padding;
    
    _imageSize = image.size;
    _textSize = textRect.size;
    self.frame = frame;
    [self layoutIfNeeded];
}


- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        _imageView = imageView;
    }
    
    return _imageView;
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
