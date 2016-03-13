//
//  ExampleModel.m
//  DGTools
//
//  Created by Gavin on 16/3/13.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "ExampleModel.h"

@implementation ExampleModel

//  可以通过实现父类的-initContentWithDic:方法来进行key的特殊性value处理
- (id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        //  在此根据key进行有特殊性的处理操作
    }
    return self;
}

@end
