//
//  TopAlertView.m
//  JKBMobile
//
//  Created by dusk on 14-10-14.
//  Copyright (c) 2014年 Wandusoft. All rights reserved.
//

#import "TopAlertView.h"
#import "AppDelegate.h"

@implementation TopAlertView{
    NSTimer *timer;
    UILabel *textLabel;
    BOOL *isShowing;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        self.backgroundColor = [UIColor redColor];
        UIWindow *window=((AppDelegate *)[UIApplication sharedApplication].delegate).window;
        [window addSubview:self];
        textLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-30, self.frame.size.width-20, 30)];
        textLabel.font=[UIFont systemFontOfSize:12];
        textLabel.backgroundColor=[UIColor clearColor];
        textLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:textLabel];
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)onClick{
    [self close];
    [self.delegate topAlertView:self onClickWithParameter:self.param];
}
-(void)show{
    if (timer) {
        [timer invalidate];
    }
    if (!isShowing) {
        textLabel.text=[[self.param objectForKey:@"aps"] objectForKey:@"alert"];
        [UIView animateWithDuration:0.2 animations:^{
            self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished){
            isShowing=YES;
            timer=[NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(close) userInfo:nil repeats:YES];
        }];
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            self.frame=CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished){
            textLabel.text=[[self.param objectForKey:@"aps"] objectForKey:@"alert"];
            [UIView animateWithDuration:0.2 animations:^{
                self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            } completion:^(BOOL finished){
                isShowing=YES;
                timer=[NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(close) userInfo:nil repeats:YES];
            }];
        }];
    }
    
}
-(void)close{
    [timer invalidate];
    [UIView animateWithDuration:0.2 animations:^{
        self.frame=CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished){
        isShowing=NO;
    }];
}
@end
