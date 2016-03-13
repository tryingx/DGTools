//
//  JsonDataModel.h
//  DGTools
//
//  Created by Gavin on 16/3/13.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonDataModel : NSObject

/**
 *  Description
 *
 *  @param jsonDic json字典
 *
 *  @return Model self
 */
- (id)initContentWithDic:(NSDictionary *)jsonDic;

/**
 *  Description
 *
 *  @param jsonDic json字典
 */
- (void)setAttributes:(NSDictionary *)jsonDic;

/**
 *  Description
 *
 *  @param jsonDic json字典
 *
 *  @return return value description
 */
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic;

@end
