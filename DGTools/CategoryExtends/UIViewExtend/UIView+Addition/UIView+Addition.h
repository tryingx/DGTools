//
//  UIView+Addition.h
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic,readonly) CGFloat orientationWidth;
@property(nonatomic,readonly) CGFloat orientationHeight;

@property (nonatomic, retain) NSObject *attachment; //在视图中附加一个绑定数据

- (void)removeSubviews;
- (CGPoint)centerOfFrame;
- (CGPoint)centerOfBounds;

+ (void)drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor*)color;

@end
