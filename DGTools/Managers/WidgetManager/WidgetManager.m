//
//  WidgetManager.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "WidgetManager.h"

@implementation WidgetManager

#pragma mark - 隐藏状态栏
+ (BOOL)isHiddenStatusBar
{
    BOOL isHidden = NO;
    UIApplication *app = [UIApplication sharedApplication];
    id hotStr = [[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"currentDoubleHeightText"];
    if([hotStr isEqualToString:@""]){
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        isHidden = NO;
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        isHidden = YES;
    }
    return isHidden;
}

+(void)hideTabBar{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //    if (app.menuController.tabBarController.tabBar.hidden==YES) {
    //        return;
    //    }
    
    //    UIView *contentView;
    //    if ([[app.menuController.tabBarController.view.subviews objectAtIndex:0]isKindOfClass:[UITabBar class]]) {
    //        contentView=[app.menuController.tabBarController.view.subviews objectAtIndex:1];
    //    }else{
    //        contentView=[app.menuController.tabBarController.view.subviews objectAtIndex:0];
    //    }
    //    if (IOS7) {
    //        contentView.frame=CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height);
    //    }else{
    //        contentView.frame=CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height+app.tbc.tabBar.frame.size.height);
    //    }
    //    app.menuController.tabBarController.tabBar.hidden=YES;
    
    
    app.mainTabBarController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 49);
    
}
+(void)showTabBar{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //    if (app.menuController.tabBarController.tabBar.hidden==NO) {
    //        return;
    //    }
    //    UIView *contentView;
    //    if ([[app.menuController.tabBarController.view.subviews objectAtIndex:0]isKindOfClass:[UITabBar class]]) {
    //        contentView=[app.menuController.tabBarController.view.subviews objectAtIndex:1];
    //    }else{
    //        contentView=[app.menuController.tabBarController.view.subviews objectAtIndex:0];
    //    }
    //    if (IOS7) {
    //        contentView.frame=CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height);
    //    }else{
    //        contentView.frame=CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height+app.tbc.tabBar.frame.size.height);
    //    }
    //    app.menuController.tabBarController.tabBar.hidden=NO;
    
    app.mainTabBarController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}

@end
