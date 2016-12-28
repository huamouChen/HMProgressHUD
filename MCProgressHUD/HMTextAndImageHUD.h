//
//  HMTextAndImageHUD.h
//  MCProgressHUD
//
//  Created by  Minstone on 2016/11/17.
//  Copyright © 2016年 minstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTextAndImageHUD : UIView
/** 设置文字颜色 */
@property (strong, nonatomic) UIColor *textColor;
/** 设置提示文字和图片*/
- (void)setText:(NSString *)text andImage:(UIImage *)image;

@end
