//
//  DLLineCharView.m
//  DLStatisticalchart
//
//  Created by macbook on 16/1/22.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import "DLLineCharView.h"

@interface DLLineCharView (){
    NSString * _xTitle;
    NSString * _yTitle;
    
    CGFloat _xMax;
    CGFloat _xMin;
    
    CGFloat _yMax;
    CGFloat _yMin;
    
    CGFloat _xDuring;
    CGFloat _yDuring;
}
@property (nonatomic,copy)NSArray* selectPoints;

@end

@implementation DLLineCharView


-(void)yMax:(CGFloat)max min:(CGFloat)min during:(CGFloat)during andTitle:(NSString *)title{
    [super yMax:max min:min during:during andTitle:title];
    _yMax = max;
    _yMin = min;
    _yDuring = during;
}

-(void)xMax:(CGFloat)max min:(CGFloat)min during:(CGFloat)during andTitle:(NSString *)title{
    [super xMax:max min:min during:during andTitle:title];
    _xMax = max;
    _xMin = min;
    _xDuring = during;
}



- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    NSMutableArray * xPoints = [NSMutableArray array];
    NSMutableArray * yPoints = [NSMutableArray array];
    NSMutableArray * xTitles = [NSMutableArray array];
    NSMutableArray * yTitles = [NSMutableArray array];
    if (_xMax||_yMax) {
        if (_xMin == 0 && _yMin == 0) {
            CGFloat x = _xDuring;
            CGFloat y = _yDuring;
            while (x<_xMax) {
                [xPoints addObject:[NSValue valueWithCGPoint:CGPointMake(x, 0)]];
                [xTitles addObject:[NSString stringWithFormat:@"%d",(int)x]];
                x+=_xDuring;
            }
            while (y<_yMax) {
                [yPoints addObject:[NSValue valueWithCGPoint: CGPointMake(0, y)]];
                [yTitles addObject:[NSString stringWithFormat:@"%d",(int)y]];
                y+=_yDuring;
            }
        }

        [self createXWithPoints:[xPoints copy] andTitles:[xTitles copy]];
        [self createYWithPoints:[yPoints copy] andTitles:[yTitles copy]];
        [self createZeroPoint];
        
        [self selectPoints:_selectPoints];
    }
}

- (void)setSelectPoints:(NSArray *)points{
    _selectPoints = [NSArray arrayWithArray:points];
}

@end
