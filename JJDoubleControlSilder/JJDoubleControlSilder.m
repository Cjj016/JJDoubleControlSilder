//
//  JJDoubleControlSilder.m
//  JJDoubleControlSilder
//
//  Created by Joey Chan on 2018/12/27.
//  Copyright © 2018年 Joey Chan. All rights reserved.
//

#import "JJDoubleControlSilder.h"
@interface JJDoubleControlSilder ()
@property (nonatomic , strong) JJDoubleControlSilderSetting *setting;
@property (nonatomic , strong) UIView *basicLine;
@property (nonatomic , strong) UIView *leftLine;
@property (nonatomic , strong) UIView *rightLine;
@property (nonatomic , strong) NSMutableArray *stepCountViews;

@property (nonatomic , strong) UIView *leftControl;
@property (nonatomic , strong) UIView *rightControl;

@property (nonatomic , assign) CGFloat leftValue;
@property (nonatomic , assign) CGFloat rightValue;

@end

@implementation JJDoubleControlSilder

- (instancetype)initWithFrame:(CGRect)frame silderSetting:(JJDoubleControlSilderSetting *)silderSetting {
    self = [super initWithFrame:frame];
    if (self) {
        self.setting = silderSetting;
        [self setupLine];
        [self setupLeftControl];
        [self setupRightControl];
        self.leftValue = silderSetting.minValue;
        self.rightValue = silderSetting.maxValue;
    }
    return self;
}
- (void)setupLine {
    ///进度底轴
    UIView *basicLine = [[UIView alloc] initWithFrame:CGRectMake(self.setting.lineSpacing, self.setting.itemSize/2 - self.setting.lineHeight/2, self.frame.size.width - (self.setting.lineSpacing * 2), self.setting.lineHeight)];
    basicLine.backgroundColor = self.setting.basicLineColor;
    [self addSubview:basicLine];
    self.basicLine = basicLine;
    
    //左边进度轴
    UIView *leftLine = [[UIView alloc] init];
    [basicLine addSubview:leftLine];
    leftLine.frame = CGRectMake(0, 0, 0, basicLine.frame.size.height);
    leftLine.backgroundColor = self.setting.leftLineColor;
    self.leftLine = leftLine;
    
    //左边进度轴
    UIView *rightLine = [[UIView alloc] init];
    [basicLine addSubview:rightLine];
    rightLine.frame = CGRectMake(basicLine.frame.size.width, 0, 0, basicLine.frame.size.height);
    rightLine.backgroundColor = self.setting.leftLineColor;
    self.rightLine = rightLine;
    
    
    
    ///检查是否需要展示分段点
    if (self.setting.showStepCount) {
        
        ///kvo监听frame的改变
        [self.leftLine addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        [self.rightLine addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        NSLog(@"self.basicLine.frame.size.width/self.setting.stepCount == %f",self.basicLine.frame.size.width/self.setting.stepCount);
        self.stepCountViews = [NSMutableArray array];
        for (NSUInteger i = 0; i < self.setting.stepCount + 1; i++) {
            UIView *stepView = [[UIView alloc] initWithFrame:CGRectMake(-self.setting.stepSize/2 + self.basicLine.frame.size.width/self.setting.stepCount * i, self.setting.lineHeight/2 - self.setting.stepSize/2, self.setting.stepSize, self.setting.stepSize)];
            [basicLine addSubview:stepView];
            stepView.backgroundColor = self.setting.basicLineColor;
            stepView.layer.cornerRadius = self.setting.stepSize/2;
            [self.stepCountViews addObject:stepView];
        }
    }
    
    
    
}









///创建左边的控制进度器
- (void)setupLeftControl {
    UIView *leftControl = [[UIView alloc] init];
    [self addSubview:leftControl];
    leftControl.frame = CGRectMake(-self.setting.itemSize/2 + self.setting.lineSpacing, 0, self.setting.itemSize, self.setting.itemSize);
    leftControl.backgroundColor = [UIColor whiteColor];
    leftControl.layer.cornerRadius = self.setting.itemSize/2;
    leftControl.layer.shadowOpacity = 0.2f;
    leftControl.layer.shadowRadius = 4.0f;
    leftControl.layer.shadowOffset = CGSizeMake(0, 0);
    //    leftControl.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, leftControl.bounds.size.width, leftControl.bounds.size.height)].CGPath;
    //设置缓存
    leftControl.layer.shouldRasterize = YES;
    //设置抗锯齿边缘
    leftControl.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.leftControl = leftControl;
    
    
    UIView *leftControlSubView = [[UIView alloc] init];
    [leftControl addSubview:leftControlSubView];
    leftControlSubView.frame = CGRectMake(self.setting.itemSize/4, self.setting.itemSize/4, self.setting.itemSize/2, self.setting.itemSize/2);
    leftControlSubView.backgroundColor = self.setting.basicLineColor;
    leftControlSubView.layer.cornerRadius = self.setting.itemSize/4;
    
    UIPanGestureRecognizer* padLeft = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftEventPan:)];
    [self.leftControl addGestureRecognizer:padLeft];
}

///创建左边的控制进度器
- (void)setupRightControl {
    UIView *rightControl = [[UIView alloc] init];
    [self addSubview:rightControl];
    rightControl.frame = CGRectMake(self.basicLine.frame.size.width - self.setting.itemSize/2 + self.setting.lineSpacing, 0, self.setting.itemSize, self.setting.itemSize);
    rightControl.backgroundColor = [UIColor whiteColor];
    rightControl.layer.cornerRadius = self.setting.itemSize/2;
    rightControl.layer.shadowOpacity = 0.2f;
    rightControl.layer.shadowRadius = 4.0f;
    rightControl.layer.shadowOffset = CGSizeMake(0, 0);
    //    leftControl.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, leftControl.bounds.size.width, leftControl.bounds.size.height)].CGPath;
    //设置缓存
    rightControl.layer.shouldRasterize = YES;
    //设置抗锯齿边缘
    rightControl.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.rightControl = rightControl;
    
    
    UIView *rughtControlSubView = [[UIView alloc] init];
    [rightControl addSubview:rughtControlSubView];
    rughtControlSubView.frame = CGRectMake(self.setting.itemSize/4, self.setting.itemSize/4, self.setting.itemSize/2, self.setting.itemSize/2);
    rughtControlSubView.backgroundColor = self.setting.basicLineColor;
    rughtControlSubView.layer.cornerRadius = self.setting.itemSize/4;
    
    UIPanGestureRecognizer* padRight = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightEventPan:)];
    [self.rightControl addGestureRecognizer:padRight];
}


///监听左边滑动
- (void)leftEventPan:(UIPanGestureRecognizer*)pan {
    CGPoint point = [pan translationInView:self];
    static CGPoint center;
    if (pan.state == UIGestureRecognizerStateBegan) {
        center = pan.view.center;
    } else if(pan.state == UIGestureRecognizerStateEnded){
        pan.view.userInteractionEnabled = YES;
    }
    
    if (center.x + point.x - self.setting.lineSpacing>= 0 && center.x + point.x  - self.setting.lineSpacing<= self.basicLine.frame.size.width) {
        pan.view.center = CGPointMake(center.x + point.x, self.setting.itemSize/2);
        CGRect copyLineFrame = self.leftLine.frame;
        copyLineFrame.size.width = center.x + point.x - self.setting.lineSpacing;
        self.leftLine.frame = copyLineFrame;
        CGFloat selectLefttValue = (copyLineFrame.size.width * self.setting.maxValue)/self.basicLine.frame.size.width;
        NSLog(@"selectLefttValue == %f",selectLefttValue);
        self.leftValue = selectLefttValue;
        
        if (self.selectValue) {
            self.selectValue(self.leftValue,self.rightValue);
        }
    }
    
}

///监听右边滑动
- (void)rightEventPan:(UIPanGestureRecognizer*)pan {
    CGPoint point = [pan translationInView:self];
    static CGPoint center;
    if (pan.state == UIGestureRecognizerStateBegan) {
        center = pan.view.center;
    } else if(pan.state == UIGestureRecognizerStateEnded){
        
        pan.view.userInteractionEnabled = YES;
    }
    
    if (center.x + point.x - self.setting.lineSpacing>= 0 && center.x + point.x  - self.setting.lineSpacing<= self.basicLine.frame.size.width) {
        pan.view.center = CGPointMake(center.x + point.x, self.setting.itemSize/2);
        CGRect copyLineFrame = self.rightLine.frame;
        copyLineFrame.origin.x = center.x + point.x - self.setting.lineSpacing;
        copyLineFrame.size.width = self.basicLine.frame.size.width - (center.x + point.x - self.setting.lineSpacing);
        self.rightLine.frame = copyLineFrame;
        CGFloat selectRightValue = copyLineFrame.size.width * self.setting.maxValue/self.basicLine.frame.size.width;
        NSLog(@"selectRightValue == %f",selectRightValue);
        self.rightValue = self.setting.maxValue - selectRightValue;
        if (self.selectValue) {
            self.selectValue(self.leftValue,self.rightValue);
        }
    }
    
}


- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    
    CGFloat haveColorWidth = self.basicLine.frame.size.width - self.rightLine.frame.size.width;
    
    for (UIView *roundView in self.stepCountViews) {
        if (roundView.frame.origin.x < self.leftLine.frame.size.width) {
            
            roundView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
            
            if (roundView.frame.origin.x > haveColorWidth) {
                
                roundView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
            }
            
        } else if (roundView.frame.origin.x > haveColorWidth) {
            
            roundView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
            
        } else {
            roundView.backgroundColor = [UIColor colorWithRed:58.0f/255.0f green:89.0f/255.0f blue:105.0f/255.0f alpha:1.0f];
        }
        
    }
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
