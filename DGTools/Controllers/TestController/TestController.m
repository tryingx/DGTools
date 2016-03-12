//
//  TestController.m
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

//  Test Import
//---------------------

#import "SIAlertView.h"
#import "TopAlertView.h"

//---------------------


#import "TestController.h"

@interface TestController ()<TopAlertViewDelegate>

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"TestController";
    self.view.backgroundColor = [UIColor yellowColor];
    [self goTestMethod];
}

- (void)goTestMethod{
//    SIAlertView *alertV = [[SIAlertView alloc] initWithTitle:@"这是一条测试消息" andMessage:@"zhe shi yi tiao ce shi xiao xi"];
//    [alertV show];
    
//    TopAlertView *topAlertView = [[TopAlertView alloc] initWithFrame:CGRectMake(0, -50, self.view.bounds.size.width, 50)];
//    topAlertView.param = @{@"key":@"value",@"name":@"topAlertView"};
//    topAlertView.delegate = self;
//    [topAlertView show];
    NSLog(@"-----------------");
    sleep(2);
    NSLog(@"ssssssss");
    
}

//- (void)topAlertView:(TopAlertView *) alertView onClickWithParameter:(NSDictionary*)dic{
//    NSLog(@"%@",dic);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
