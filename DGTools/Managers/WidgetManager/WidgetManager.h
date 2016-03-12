//
//  WidgetManager.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WidgetManager : NSObject

//  隐藏状态栏
+ (BOOL)isHiddenStatusBar;

//  隐藏TabBar
+(void)hideTabBar;
//  显示TabBar
+(void)showTabBar;

@end
