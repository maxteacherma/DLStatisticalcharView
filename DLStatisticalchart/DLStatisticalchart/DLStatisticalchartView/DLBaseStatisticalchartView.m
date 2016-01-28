//
//  DLBaseStatisticalchartView.m
//  DLStatisticalchart
//
//  Created by macbook on 16/1/22.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import "DLBaseStatisticalchartView.h"


#define NOWPointX(x) x+45-3
#define NOWPointY(y) y+3

@interface DLBaseStatisticalchartView (){
    CGFloat _width;
    CGFloat _height;
    CGFloat _arrowLine;
    
    CGFloat _xMax;
    CGFloat _xMin;
    CGFloat _yMax;
    CGFloat _yMin;
    CGFloat _xDuring;
    CGFloat _yDuring;
    
    CGFloat _xDuringFrame;
    CGFloat _yDuringFrame;
    
    NSString * _xTitle;
    NSString * _yTitle;
}

@end


@implementation DLBaseStatisticalchartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _width = self.frame.size.width-45;
        _height = self.frame.size.height-45;
        _arrowLine = _width>_height?_width/30-3:_height/30-3;
    }
    return self;
}


- (CGPoint)xyPointToCGPoint:(CGPoint)point{
    return CGPointMake(point.x, _height-point.y);
}

- (void)drawRect:(CGRect)rect{
    [self createXY];

}

//创建x，y坐标系
- (void)createXY{
    //xy
    [self createLinePointA:[self xyPointToCGPoint:CGPointMake(0, 0)] toPointB:[self xyPointToCGPoint:CGPointMake(0, _height)]];
    [self createLinePointA:[self xyPointToCGPoint:CGPointMake(0, 0)] toPointB:[self xyPointToCGPoint:CGPointMake(_width, 0)]];
    //箭头
    [self createLineWithPointArray:@[[NSValue valueWithCGPoint:CGPointMake(-_arrowLine, _arrowLine)],[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(_arrowLine, _arrowLine)]]];
    [self createLineWithPointArray:@[[NSValue valueWithCGPoint:CGPointMake(_width-_arrowLine, _height-_arrowLine)],[NSValue valueWithCGPoint:CGPointMake(_width, _height)],[NSValue valueWithCGPoint:CGPointMake(_width-_arrowLine, _height+_arrowLine)]]];
}

//连接点A,B
- (void)createLinePointA:(CGPoint)pointA toPointB:(CGPoint)pointB{
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextBeginPath(ctx);
    CGPathMoveToPoint(path, nil, NOWPointX(pointA.x), NOWPointY(pointA.y));
    CGPathAddLineToPoint(path, nil, NOWPointX(pointB.x), NOWPointY(pointB.y));
    //设置线条粗细
    CGContextSetLineWidth(ctx, 2);
    
    CGContextAddPath(ctx, path);
    //渲染
    CGContextStrokePath(ctx);
    //释放
    //CFRelease(ctx);
}

//连接点A,B,C...（NSArray）
- (void)createLineWithPointArray:(NSArray *)pointArr{
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextBeginPath(ctx);
    
    CGPoint movePoint = [pointArr[0] CGPointValue];
    
    CGPathMoveToPoint(path, nil, NOWPointX(movePoint.x), NOWPointY(movePoint.y));
    for (int i = 1; i< pointArr.count; i++) {
        CGPoint itemPoint = [pointArr[i] CGPointValue];
        CGPathAddLineToPoint(path, nil, NOWPointX(itemPoint.x), NOWPointY(itemPoint.y));
    }
    //设置线条粗细
    CGContextSetLineWidth(ctx, 2);
    CGContextAddPath(ctx, path);
    //渲染
    CGContextStrokePath(ctx);
}

//计算坐标系中的位置
- (CGPoint)inProportionWithMaxX:(CGFloat)maxX maxY:(CGFloat)maxY andPoint:(CGPoint)point{
    CGFloat scaleX = (_width-15)/maxX;
    CGFloat scaleY = (_height-15)/maxY;
    return [self xyPointToCGPoint:CGPointMake(point.x*scaleX, point.y*scaleY)];
}

//知道了 最大最小高度的情况
- (CGPoint)inProportionWithPoint:(CGPoint)point{
    CGFloat scaleX = (_width-15)/_xMax;
    CGFloat scaleY = (_height-15)/_yMax;
    return [self xyPointToCGPoint:CGPointMake(point.x*scaleX, point.y*scaleY)];
}

- (CGFloat)xDuringFrame{
    if (_xDuring == 0) {
        NSLog(@"error: xDuring is nil");
    }
    CGFloat scaleX = (_width-15)/_xMax;
    return scaleX*_xDuring;
}

- (CGFloat)yDuringFrame{
    if (_yDuring == 0) {
        NSLog(@"error: yDuring is nil");
    }
    CGFloat scaleY = (_height-15)/_yMax;
    return scaleY*_yDuring;
}

//绘制x轴坐标
- (void)createXWithPoints:(NSArray *)points andTitles:(NSArray *)titles{
    for (int i = 0; i<points.count; i++) {
        CGPoint nowPoint = [self inProportionWithPoint:[points[i] CGPointValue]];
        //NSLog(@"%@",[NSValue valueWithCGPoint:nowPoint]);
        CGPoint newPoint = [self xyPointToCGPoint:CGPointMake(nowPoint.x, 3)];
        [self createLinePointA:nowPoint toPointB:newPoint];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(NOWPointX(nowPoint.x-_xDuringFrame/2), NOWPointY(nowPoint.y), _xDuringFrame, _yDuringFrame)];
        label.text = titles[i];
        //label.backgroundColor = [UIColor orangeColor];
        //label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:_xDuringFrame-8];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}

//绘制y轴坐标
- (void)createYWithPoints:(NSArray *)points andTitles:(NSArray *)titles{
    for (int i = 0; i<points.count; i++) {
        CGPoint nowPoint = [self inProportionWithPoint:[points[i] CGPointValue]];
        //NSLog(@"%@",[NSValue valueWithCGPoint:nowPoint]);
        //这里的y已经颠倒过了
        CGPoint newPoint = CGPointMake(3, nowPoint.y);
        [self createLinePointA:nowPoint toPointB:newPoint];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(NOWPointX(nowPoint.x-_xDuringFrame)-15, NOWPointY(nowPoint.y-_yDuringFrame/2), _xDuringFrame+15, _yDuringFrame)];
        label.text = titles[i];
        //label.backgroundColor = [UIColor orangeColor];
        //label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:_xDuringFrame-5];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}

//获取x坐标轴信息
-(void)xMax:(CGFloat)max min:(CGFloat)min during:(CGFloat)during andTitle:(NSString *)title{
    _xMax = max;
    _xMin = min;
    _xDuring = during;
    _xTitle = title;
    
    _xDuringFrame = self.xDuringFrame;
    NSLog(@"xDuringFrame:%lf",_xDuringFrame);
    //
}
//获取y坐标轴信息
-(void)yMax:(CGFloat)max min:(CGFloat)min during:(CGFloat)during andTitle:(NSString *)title{
    _yMax = max;
    _yMin = min;
    _yDuring = during;
    _yTitle = title;
    
    _yDuringFrame = self.yDuringFrame;
    NSLog(@"yDuringFrame:%lf",_yDuringFrame);
    //
}

//创建原点坐标
- (void)createZeroPoint{
    if (_xDuringFrame!=0 && _yDuringFrame!=0) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(NOWPointX(-_xDuringFrame), _height+3, _xDuringFrame, _yDuringFrame)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:_xDuringFrame-5];
        label.text = @"0";
        //label.backgroundColor = [UIColor purpleColor];
        [self addSubview:label];
    }
    
}

//选中点连线
- (void)selectPoints:(NSArray *)points{
    
    NSMutableArray * newPoints = [NSMutableArray array];
    for (NSValue * pointValue in points) {
        CGPoint newPoint = [pointValue CGPointValue];
        [newPoints addObject:[NSValue valueWithCGPoint:[self inProportionWithPoint:newPoint]]];
    }
    [self createLineWithPointArray:newPoints];
}

@end
