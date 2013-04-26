//
//  CXCStringToArray.m
//  cxcnames
//
//  Created by Terence Chen on 12-8-11.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "CXCStringToArray.h"

@implementation CXCStringToArray
- (NSArray *)StringToArray:(NSString *)string
{
    NSLog(@"CXC字符串转换类被调用，使用字符串转数组方法。\n%@",[string componentsSeparatedByString:@"，"]);
    return [string componentsSeparatedByString:@"，"];
}
- (NSString *)ArrayToString:(NSArray *)array
{
    NSLog(@"CXC字符串转换类被调用，使用数组转字符串方法。\n%@",[array componentsJoinedByString:@"，"]);
    return [array componentsJoinedByString:@"，"];
}
@end
