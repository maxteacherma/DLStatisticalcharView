//
//  ViewController.m
//  DLStatisticalchart
//
//  Created by macbook on 16/1/22.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import "ViewController.h"

#import "DLLineCharView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DLLineCharView * view = [[DLLineCharView alloc]initWithFrame:CGRectMake(20, 84, 300, 200)];

    [view xMax:200 min:0 during:15 andTitle:@"xTitle"];
    [view yMax:200 min:0 during:30 andTitle:@"yTitle"];
    [view setSelectPoints:@[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(15, 90)],[NSValue valueWithCGPoint:CGPointMake(30, 112)],[NSValue valueWithCGPoint:CGPointMake(45, 45)],[NSValue valueWithCGPoint:CGPointMake(60, 78)],[NSValue valueWithCGPoint:CGPointMake(75, 96)],[NSValue valueWithCGPoint:CGPointMake(90, 12)],[NSValue valueWithCGPoint:CGPointMake(105, 0)],[NSValue valueWithCGPoint:CGPointMake(120, 89)],[NSValue valueWithCGPoint:CGPointMake(135, 133)]]];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
