//
//  HMProgressHUDView.h
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMProgressHUDView : UIView
/** 设置颜色 */
@property (strong, nonatomic) UIColor *indicatorColor;
/** 开始动画 */
- (void)startAnimation;
/** 设置文字提示 */
- (void)setText:(NSString *)text;

@end
