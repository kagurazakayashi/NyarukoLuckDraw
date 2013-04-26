//
//  CXCFileExists.m
//  cxcnames
//
//  Created by Terence Chen on 12-8-10.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "CXCFileExists.h"

@implementation CXCFileExists
- (BOOL) existscxcfile:(NSString *)cxcfile
{
    NSLog(@"CXC文件存在检查类被执行。\n%@",cxcfile);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:cxcfile];
}
@end