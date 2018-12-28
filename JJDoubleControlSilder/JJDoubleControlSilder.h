//
//  JJDoubleControlSilder.h
//  JJDoubleControlSilder
//
//  Created by Joey Chan on 2018/12/27.
//  Copyright © 2018年 Joey Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJDoubleControlSilderSetting.h"
NS_ASSUME_NONNULL_BEGIN

@interface JJDoubleControlSilder : UIView
- (instancetype)initWithFrame:(CGRect)frame silderSetting:(JJDoubleControlSilderSetting *)silderSetting;
@property (nonatomic , copy) void(^selectValue)(CGFloat leftVelue,CGFloat rightVelue);
@end

NS_ASSUME_NONNULL_END
