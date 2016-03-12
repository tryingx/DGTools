//
//  CoderModel.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

static NSString *IDKey      = @"IDKey";
static NSString *NameKey    = @"NameKey";
static NSString *AgeKey     = @"AgeKey";
static NSString *SexKey     = @"SexKey";
static NSString *AddressKey = @"AddressKey";
static NSString *MobileKey  = @"MobileKey";

#import "CoderModel.h"

@implementation CoderModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:self.ID forKey:IDKey];
    [aCoder encodeObject:self.name forKey:NameKey];
    [aCoder encodeInt:self.age forKey:AgeKey];
    [aCoder encodeObject:self.sex forKey:SexKey];
    [aCoder encodeObject:self.address forKey:AddressKey];
    [aCoder encodeObject:self.mobile forKey:MobileKey];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.ID = [[aDecoder decodeObjectForKey:IDKey] intValue];
        self.name = [aDecoder decodeObjectForKey:NameKey];
        self.age = [[aDecoder decodeObjectForKey:AgeKey] intValue];
        self.sex = [aDecoder decodeObjectForKey:SexKey];
        self.address = [aDecoder decodeObjectForKey:AddressKey];
        self.mobile = [aDecoder decodeObjectForKey:MobileKey];
        
    }
    return self;
}

@end
