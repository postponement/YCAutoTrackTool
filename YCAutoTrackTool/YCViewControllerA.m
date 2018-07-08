//
//  YCViewControllerA.m
//  YCAutoTrackTool
//
//  Created by liuyanchi on 2018/7/8.
//  Copyright © 2018年 yidaoyongche. All rights reserved.
//

#import "YCViewControllerA.h"

@interface YCViewControllerA ()

@end

@implementation YCViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    tempView.backgroundColor = [UIColor redColor];
    tempView.userInteractionEnabled = YES;
    [self.view addSubview:tempView];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] init];
    [ges addTarget:self action:@selector(gesClick)];
    [tempView addGestureRecognizer:ges];
}

- (void)gesClick
{
    NSLog(@"%s",__func__);

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
