//
//  HMImageOnlyHUD.m
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import "HMImageOnlyHUD.h"
#import "HMPrivateHUDdProtocol.h"

@interface HMImageOnlyHUD ()<HMPrivateHUDdProtocol>
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation HMImageOnlyHUD

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

#pragma mark - 设置外观
- (void)setupAppearance {
    [self addSubview:self.imageView];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.bounds.size.width - self.image.size.width) / 2.0, (self.bounds.size.height - self.image.size.height) / 2.0, self.image.size.width, self.image.size.height);
}

#pragma mark - setter && getter
- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
    CGRect frame = self.frame;
    frame.size = CGSizeMake(image.size.width + 45, image.size.height + 45);
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
@end
