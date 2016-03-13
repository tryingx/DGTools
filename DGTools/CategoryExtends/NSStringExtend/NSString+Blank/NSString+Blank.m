//
//  NSString+Blank.m
//  DGTools
//
//  Created by Gavin on 16/3/13.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "NSString+Blank.h"

@implementation NSString (Blank)

+ (instancetype)returnBlankValue:(id)value{
    
     if (value == nil) {
         return @"";
     }
    
     if (value == NULL) {
        
         return @"";
        
         }
    
     if ([value isKindOfClass:[NSNull class]]) {
        
         return @"";
        
         }
    
     if ([[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
         
         return @"";
         
         }
     
     return value;
     
     }

@end
