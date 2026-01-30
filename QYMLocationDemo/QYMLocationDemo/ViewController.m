//
//  ViewController.m
//  QYMLocationDemo
//
//  Created by Jack on 2020/4/17.
//  Copyright © 2020 JLPAY. All rights reserved.
//

#import "ViewController.h"
#import <QYMLocationHeader.h>

@interface ViewController ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) QYMLocationManager *locManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, UIScreen.mainScreen.bounds.size.width-30, 50)];
    label.numberOfLines   = 0;
    label.preferredMaxLayoutWidth = UIScreen.mainScreen.bounds.size.width-30;
    label.backgroundColor = [UIColor clearColor];
    label.textColor       = [UIColor blackColor];
    label.font            = [UIFont systemFontOfSize:16];
    label.textAlignment   = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.textLabel = label;
    
    NSArray *btnTitles = @[@"检查权限", @"定位"];
    for (int i = 0; i < btnTitles.count; i++ ) {
        
        NSString *title = btnTitles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 10+i;
        button.frame = CGRectMake(15, 170+65*i, [UIScreen mainScreen].bounds.size.width-30, 50);
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)buttonClicked:(UIButton *)button{
    NSInteger index = button.tag - 10;
    if(index == 0){
        BOOL success= [QYMLocationAuthority checkLocAuthorizationAndShowAlertWithVC:self];
        self.textLabel.text = success ? @"有定位权限" : @"无权限或未开始授权";
     }
    else{
        
        self.locManager = [[QYMLocationManager alloc] init];
        __weak typeof(self)weakSelf = self;
        [self.locManager startLocationWithResutlBlock:^(BOOL success, NSArray * _Nullable locations, NSError * _Nullable error) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if(success){
                CLLocation *location = locations.firstObject;
                strongSelf.textLabel.text = [NSString stringWithFormat:@"定位成功:%f,%f",location.coordinate.latitude, location.coordinate.longitude];
            }
            else{
                strongSelf.textLabel.text = [NSString stringWithFormat:@"定位失败:%@", error.localizedDescription];
            }
        }];
        
    }
}


@end
