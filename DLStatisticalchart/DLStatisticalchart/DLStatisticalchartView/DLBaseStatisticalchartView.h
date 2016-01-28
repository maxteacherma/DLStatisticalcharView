//
//  DLBaseStatisticalchartView.h
//  DLStatisticalchart
//
//  Created by macbook on 16/1/22.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLBaseStatisticalchartView : UIView

- (void)createXY;
- (void)createLinePointA:(CGPoint)pointA toPointB:(CGPoint)pointB;
- (void)createLineWithPointArray:(NSArray *)pointArr;

- (CGPoint)inProportionWithMaxX:(CGFloat)maxX maxY:(CGFloat)maxY andPoint:(CGPoint)point;
- (CGPoint)inProportionWithPoint:(CGPoint)point;
- (CGPoint)xyPointToCGPoint:(CGPoint)point;

- (void)createXWithPoints:(NSArray *)points andTitles:(NSArray *)titles ;
- (void)createYWithPoints:(NSArray *)points andTitles:(NSArray *)titles;

- (void)xMax:(CGFloat)max min:(CGFloat)min during:(CGFloat)during andTitle:(NSString *)title;
- (void)yMax:(CGFloat)max min:(CGFloat)min during:(CGFloat)during andTitle:(NSString *)title;

- (void)createZeroPoint;
- (void)selectPoints:(NSArray *)points;

@end

