//
//  CXCFileIO.m
//  cxcnames
//
//  Created by Terence Chen on 12-8-10.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "CXCFileIO.h"

@implementation CXCFileIO
- (NSString *)readcxcfile:(NSString *)cxcfile //读取
{
    NSLog(@"CXC磁盘操作类被执行，调用了读取方法。\n%@",cxcfile);
//    NSString *rFileInfo = [NSString stringWithContentsOfFile:cxcfile encoding:NSUTF8StringEncoding error:nil];
    NSData *rData = [NSData dataWithContentsOfFile:cxcfile];
    return [[NSString alloc] initWithData:rData encoding:NSUTF8StringEncoding];
}
- (BOOL)writingcxcfile:(NSString *)cxcfile Cont:(NSString *)cxccont //续写
{
    NSLog(@"CXC磁盘操作类被执行，调用了续写方法。\n%@\n%@",cxcfile,cxccont);
    NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:cxcfile append:YES];
    [outStream open];
    NSData *data = [cxccont dataUsingEncoding:NSUTF8StringEncoding];
    BOOL result = [outStream write:data.bytes maxLength:data.length];
    [outStream close];
    return result;
}
- (BOOL)covercxcfile:(NSString *)cxcfile Cont:(NSString *)cxccont //覆盖
{
    NSLog(@"CXC磁盘操作类被执行，调用了覆盖方法。\n%@\n%@",cxcfile,cxccont);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL result = [fileManager removeItemAtPath:cxcfile error:&error];
    NSLog(@"!error = %d , result = %d",!error,result);
    if (error&&!result) //!error&&result
    {
        NSData *myfileData = [cxccont dataUsingEncoding:NSUTF8StringEncoding];
        return [fileManager createFileAtPath:cxcfile contents:myfileData attributes:nil];
    } else {
        return false;
    }
}
- (BOOL)removecxcfile:(NSString *)cxcfile //删除
{
    NSLog(@"CXC磁盘操作类被执行，调用了删除方法。\n%@",cxcfile);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSError *error = nil;
    return  [fileManager removeItemAtPath:cxcfile error:nil];
}
- (BOOL)copycxcfile:(NSString *)cxcfile Cont:(NSString *)cxctofile //复制
{
    NSLog(@"CXC磁盘操作类被执行，调用了复制方法。\n%@\n%@",cxcfile,cxctofile);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager copyItemAtPath:cxcfile toPath:cxctofile error:nil];
}
- (BOOL)movecxcfile:(NSString *)cxcfile Cont:(NSString *)cxctofile //移动
{
    NSLog(@"CXC磁盘操作类被执行，调用了移动方法。\n%@\n%@",cxcfile,cxctofile);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager moveItemAtPath:cxcfile toPath:cxctofile error:nil];
}
- (NSArray *)condir:(NSString *)cxcfile //列出目录
{
    NSLog(@"CXC磁盘操作类被执行，调用了列目录方法。\n%@",cxcfile);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager contentsOfDirectoryAtPath:cxcfile error:nil];
}
@end
