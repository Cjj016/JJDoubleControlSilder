//
//  ViewController.m
//  JJDoubleControlSilder
//
//  Created by Joey Chan on 2018/12/27.
//  Copyright © 2018年 Joey Chan. All rights reserved.
//

#import "ViewController.h"
#import "JJDoubleControlSilder.h"
@interface ViewController ()
@property (nonatomic , strong) UILabel *cheakValueLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *cheakValueLabel = [[UILabel alloc] init];
    [self.view addSubview:cheakValueLabel];
    cheakValueLabel.frame = CGRectMake(44, 360, self.view.frame.size.width - 88, 100);
    [cheakValueLabel setFont:[UIFont systemFontOfSize:15]];
    cheakValueLabel.numberOfLines = 4;
    cheakValueLabel.text = [NSString stringWithFormat:@"设置最小默认值:0\n设置最大默认值:250\n左边的数值为:%@\n右边的数值为:%@",@"0",@"250"];
//    cheakValueLabel.backgroundColor = [UIColor redColor];
    
    JJDoubleControlSilderSetting *setting = [[JJDoubleControlSilderSetting alloc] init];
    setting.basicLineColor = [UIColor colorWithRed:58/255.0 green:89/255.0 blue:105/255.0 alpha:1.0];
    setting.leftLineColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    setting.rightLineColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    setting.lineHeight = 3;
    setting.itemSize = 33;
    setting.numberOfItem = 2;
    setting.showStepCount = YES;
    setting.stepCount = 5;
    setting.stepSize = 6;
    setting.minValue = 0;
    setting.maxValue = 250;
    setting.lineSpacing = 44;
    
    JJDoubleControlSilder *jjDoubleControlSilder = [[JJDoubleControlSilder alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 22) silderSetting:setting];
    [self.view addSubview:jjDoubleControlSilder];
    jjDoubleControlSilder.selectValue = ^(CGFloat leftVelue, CGFloat rightVelue) {
        cheakValueLabel.text = [NSString stringWithFormat:@"设置最小默认值:0\n设置最大默认值:250\n左边的数值为:%@\n右边的数值为:%@",@(ceilf(leftVelue)) ,@(ceilf(rightVelue))];
    };
}


@end
