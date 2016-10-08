//
//  UIView+MSUtil.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "UIView+MSUtil.h"

@implementation UIView (MSUtil)

+ (UIView *)ms_createDashedLineWithFrame:(CGRect)lineFrame lineLength:(int)length lineSpacing:(int)spacing lineColor:(UIColor *)color {
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

- (void)setms_x:(CGFloat)ms_x
{
    CGRect frame = self.frame;
    frame.origin.x = ms_x;
    self.frame = frame;
}

- (CGFloat)ms_x
{
    return self.frame.origin.x;
}

- (void)setms_y:(CGFloat)ms_y
{
    CGRect frame = self.frame;
    frame.origin.y = ms_y;
    self.frame = frame;
}

- (CGFloat)ms_y
{
    return self.frame.origin.y;
}

- (void)setms_w:(CGFloat)ms_w
{
    CGRect frame = self.frame;
    frame.size.width = ms_w;
    self.frame = frame;
}

- (CGFloat)ms_w
{
    return self.frame.size.width;
}

- (void)setMs_h:(CGFloat)ms_h
{
    CGRect frame = self.frame;
    frame.size.height = ms_h;
    self.frame = frame;
}

- (CGFloat)ms_h
{
    return self.frame.size.height;
}

- (void)setMs_size:(CGSize)ms_size
{
    CGRect frame = self.frame;
    frame.size = ms_size;
    self.frame = frame;
}

- (CGSize)ms_size
{
    return self.frame.size;
}

- (void)setMs_origin:(CGPoint)ms_origin
{
    CGRect frame = self.frame;
    frame.origin = ms_origin;
    self.frame = frame;
}

- (CGPoint)ms_origin
{
    return self.frame.origin;
}


- (CGFloat)left {
    return self.frame.origin.x;
}


- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}


- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
