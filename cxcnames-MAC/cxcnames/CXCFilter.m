//
//  CXCFilter.m
//  cxcnames
//
//  Created by Terence Chen on 12-8-12.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "CXCFilter.h"

@implementation CXCFilter
- (NSMutableArray *)delRepeat:(NSMutableArray *)arr
{
    NSUInteger add = 0;
    for (NSUInteger i = 0; i < [arr count]; i++)
    {
        if (i != [arr count]-1)
        {
            for (NSInteger j = i+1; j < [arr count]; j++)
            {
                NSLog(@"%@",[arr objectAtIndex:1]);
                BOOL ii = [[arr objectAtIndex:i] isEqualToString:[arr objectAtIndex:j]];
                if(ii == 1)
                {
                    [arr removeObjectsInRange:NSMakeRange(j, 1)];
                    add++;
                    NSLog(@"CXC筛选类被调用，使用数组中去重复方法。\n已删除重复条目%lu个。",add);
                }
            }
        }
    }
return arr;
}
@end
