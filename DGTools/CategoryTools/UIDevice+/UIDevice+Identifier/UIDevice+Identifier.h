//
//  UIDevice+Identifier.h
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Identifier)

- (NSString *) uniqueDeviceIdentifier;

- (NSString *) uniqueGlobalDeviceIdentifier;

@end
