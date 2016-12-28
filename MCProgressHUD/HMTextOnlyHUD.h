//
//  HMTextOnlyHUD.h
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 只显示文字的HUD
 */
@interface HMTextOnlyHUD : UIView

/**
 要显示的文字
 */
@property (copy, nonatomic) NSString *text;

/**
 文字颜色
 */
@property (strong, nonatomic) UIColor *textColor;

/**
 文字大小
 */
@property (assign, nonatomic) CGFloat fontSize;

@end
