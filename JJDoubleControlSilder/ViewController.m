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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    JJDoubleControlSilderSetting *setting = [[JJDoubleControlSilderSetting alloc] init];
    setting.basicLineColor = [UIColor colorWithRed:58/255.0 green:89/255.0 blue:105/255.0 alpha:1.0];
    setting.leftLineColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    setting.rightLineColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    setting.lineHeight = 3;
    setting.itemSize = 22;
    setting.numberOfItem = 2;
    setting.showStepCount = YES;
    setting.stepCount = 5;
    setting.stepSize = 6;
    setting.minValue = 0;
    setting.maxValue = 250;
    
    JJDoubleControlSilder *jjDoubleControlSilder = [[JJDoubleControlSilder alloc] initWithFrame:CGRectMake(22, 300, self.view.frame.size.width - 44, 22) silderSetting:setting];
    [self.view addSubview:jjDoubleControlSilder];
    jjDoubleControlSilder.selectValue = ^(CGFloat leftVelue, CGFloat rightVelue) {
        
    };
}


@end
