//
//  ViewController.m
//  YCAutoTrackTool
//
//  Created by liuyanchi on 2018/7/8.
//  Copyright © 2018年 yidaoyongche. All rights reserved.
//

#import "ViewController.h"
#import "YCViewControllerA.h"
#import "YCViewControllerB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(ViewControllerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *buttonA  = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [buttonA setBackgroundColor:[UIColor orangeColor]];
    [buttonA addTarget:self action:@selector(ViewControllerButtonAClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonA];
    
    
}

- (void)ViewControllerButtonAClick:(UIButton *)sender
{
    YCViewControllerB *vc = [YCViewControllerB new];
    [self presentViewController:vc animated:YES completion:nil];
    
    NSLog(@"%s",__func__);
    
}

- (void)ViewControllerButtonClick
{
    YCViewControllerA *vc = [YCViewControllerA new];
    [self presentViewController:vc animated:YES completion:nil];
    
    NSLog(@"%s",__func__);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
