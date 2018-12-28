//
//  JJDoubleControlSilderSetting.h
//  JJDoubleControlSilder
//
//  Created by Joey Chan on 2018/12/27.
//  Copyright © 2018年 Joey Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJDoubleControlSilderSetting : UIView

@property (nonatomic , copy) UIColor *basicLineColor;
@property (nonatomic , copy) UIColor *leftLineColor;
@property (nonatomic , copy) UIColor *rightLineColor;
//@property (nonatomic , assign) CGFloat silderWidth;
@property (nonatomic , assign) CGFloat lineHeight;
@property (nonatomic , assign) CGFloat itemSize;
@property (nonatomic , assign) NSInteger numberOfItem;
@property (nonatomic , assign) BOOL showStepCount;
@property (nonatomic , assign) NSInteger stepCount;
@property (nonatomic , assign) CGFloat stepSize;
@property (nonatomic , assign) CGFloat lineSpacing;
///设置最小值
@property (nonatomic , assign) CGFloat minValue;
///设置最大值
@property (nonatomic , assign) CGFloat maxValue;

@end

NS_ASSUME_NONNULL_END
