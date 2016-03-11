//
//  TopAlertView.h
//  JKBMobile
//
//  Created by dusk on 14-10-14.
//  Copyright (c) 2014年 Wandusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopAlertView;
@protocol TopAlertViewDelegate <NSObject>
@optional
- (void)topAlertView:(TopAlertView *) alertView onClickWithParameter:(NSDictionary*)dic;
@end

@interface TopAlertView : UIView
@property (nonatomic , weak ) id <TopAlertViewDelegate>delegate;
@property (nonatomic,strong) NSDictionary *param;
-(void)show;
@end
