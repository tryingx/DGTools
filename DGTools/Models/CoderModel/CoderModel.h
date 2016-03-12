//
//  CoderModel.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoderModel : NSObject

/**
 *  ID
 */
@property (nonatomic,assign) int ID;

/**
 *  Name
 */
@property (nonatomic,strong) NSString *name;

/**
 *  Sex
 */
@property (nonatomic,strong) NSString *sex;

/**
 *  Age
 */
@property (nonatomic,assign) int age;

/**
 *  Address
 */
@property (nonatomic,strong) NSString *address;

/**
 *  Mobile
 */
@property (nonatomic,strong) NSString *mobile;

@end
