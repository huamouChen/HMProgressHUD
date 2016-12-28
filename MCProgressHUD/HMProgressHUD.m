//
//  HMProgressHUD.m
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import "HMProgressHUD.h"

@implementation HMProgressHUD

+ (instancetype)sharedInstance {
    static HMProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[HMProgressHUD alloc] init];
    });
    return hud;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)showWithTime:(CGFloat)time {
    __weak typeof(self) weakself = self;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (self.superview == nil) {
        [window addSubview:self];
        [UIView animateWithDuration:0.2 animations:^{
            weakself.alpha = 1.0;
        }];
    }
    // 时间大于 0 ，就会自动隐藏
    if (time > 0) {
        delay(time, ^{
            __strong typeof(weakself) strongSelf = weakself;
            if (strongSelf) {
                [strongSelf hide];
            }
        });
    }
}

- (void)hide {
    __weak typeof(self) weakself = self;
    /// 首先移除先添加的
    UIView *firstHud = [self.subviews firstObject];
    if (firstHud) {
        [UIView animateWithDuration:0.2 animations:^{
            firstHud.alpha = 0.0;
        } completion:^(BOOL finished) {
            [firstHud removeFromSuperview];
            if (weakself.subviews.count == 0) {
                [UIView animateWithDuration:0.2 animations:^{
                    weakself.alpha = 0.0;
                } completion:^(BOOL finished) {
                    [weakself removeFromSuperview];
                }];
            }
        }];
    }
    else {
        [UIView animateWithDuration:0.2 animations:^{
            weakself.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakself removeFromSuperview];
        }];
        
    }
}

- (void)hideAllHUDs {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {// superView == window
        self.frame = self.superview.bounds;
        for (UIView *subview in self.subviews) {
            if ([subview conformsToProtocol:@protocol(HMPrivateHUDdProtocol)]) {
                /// 居中显示
                subview.center = self.center;
            }
            else {
                /// 自定义的hudView
                CGRect frame = subview.frame;
                subview.frame = frame;
            }
        }
    }
}
/// 这里直接使用了GCD, 当然推荐使用NSTimer
static void delay(CGFloat time, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

- (void)setHudView:(UIView *)hudView {
    [self addSubview:hudView];
}
@end


@implementation HMProgressHUD (Public)

+ (void)showProgressWithStatus:(NSString *)status {
    [UIView animateWithDuration:0 animations:^{
        // 隐藏之前的
        [HMProgressHUD hideHUD];
    } completion:^(BOOL finished) {
        HMProgressHUD *hudView = [HMProgressHUD sharedInstance];
        HMProgressHUDView *progressView = [[HMProgressHUDView alloc] init];
        [progressView setText:status];
        [hudView setHudView:progressView];
        [hudView showWithTime:0.0f];
        [progressView startAnimation];
    }];
}

+ (void)showProgress {
    [HMProgressHUD showProgressWithStatus:nil];
}

+ (void)showStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    [UIView animateWithDuration:0.2 animations:^{
        // 隐藏之前的
        [HMProgressHUD hideHUD];
    } completion:^(BOOL finished) {
        HMProgressHUD *hudView = [HMProgressHUD sharedInstance];
        HMTextOnlyHUD *textView = [[HMTextOnlyHUD alloc] init];
        textView.text = status;
        // 添加要显示的
        [hudView setHudView:textView];
        [hudView showWithTime:showTime];
    }];
}

+ (void)showStatus:(NSString *)status {
    [HMProgressHUD showStatus:status andAutoHideAfterTime:0.0f];
}

+ (void)showImage:(UIImage *)image withStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    [UIView animateWithDuration:0.2 animations:^{
        [HMProgressHUD hideHUD];
    } completion:^(BOOL finished) {
        HMProgressHUD *hudView = [HMProgressHUD sharedInstance];
        HMTextAndImageHUD *textAndImageView = [[HMTextAndImageHUD alloc] init];
        [textAndImageView setText:status andImage:image];
        [hudView setHudView:textAndImageView];
        [hudView showWithTime:showTime];
    }];
}

+ (void)showSuccessWithStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"success"];
    [HMProgressHUD showImage:image withStatus:status andAutoHideAfterTime:showTime];
}

+ (void)showSuccessWithStatus:(NSString *)status {
    [HMProgressHUD showSuccessWithStatus:status andAutoHideAfterTime:0.0f];
}


+ (void)showSuccessAndAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"success"];
    [HMProgressHUD showImage:image andAutoHideAfterTime:showTime];
}

+ (void)showSuccess {
    [HMProgressHUD showSuccessAndAutoHideAfterTime:0.0f];
}

+ (void)showErrorWithStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"error"];
    [HMProgressHUD showImage:image withStatus:status andAutoHideAfterTime:showTime];
}

+ (void)showErrorWithStatus:(NSString *)status {
    [HMProgressHUD showErrorWithStatus:status andAutoHideAfterTime:0.0f];
}

+ (void)showErrorAndAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"error"];
    [HMProgressHUD showImage:image andAutoHideAfterTime:showTime];
}

+ (void)showError {
    [HMProgressHUD showErrorAndAutoHideAfterTime:0.0f];
}


+ (void)hideHUD {
    [[HMProgressHUD sharedInstance] hide];
}

+ (void)hideAllHUDs {
    [[HMProgressHUD sharedInstance] hideAllHUDs];
}

+ (void)showCustomHUD:(UIView *)hudView andAutoHideAfterTime:(CGFloat)showTime {
    [[HMProgressHUD sharedInstance] setHudView:hudView];
    [[HMProgressHUD sharedInstance] showWithTime:showTime];
}

+ (void)showCustomHUD:(UIView *)hudView {
    [HMProgressHUD showCustomHUD:hudView andAutoHideAfterTime:0.0f];
}

+ (void)showImage:(UIImage *)image andAutoHideAfterTime:(CGFloat)showTime {
    [UIView animateWithDuration:0.2 animations:^{
        [HMProgressHUD hideHUD];
    } completion:^(BOOL finished) {
        HMProgressHUD *hudView = [HMProgressHUD sharedInstance];
        HMImageOnlyHUD *imageView = [[HMImageOnlyHUD alloc] init];
        imageView.image = image;
        [hudView setHudView:imageView];
        [hudView showWithTime:showTime];
    }];
}
@end
