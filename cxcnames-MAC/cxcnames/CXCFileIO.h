//
//  CXCFileIO.h
//  cxcnames
//
//  Created by Terence Chen on 12-8-10.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "CXCFileExists.h"

@interface CXCFileIO : CXCFileExists
- (NSString *)readcxcfile:(NSString *)cxcfile; //读取
- (BOOL)writingcxcfile:(NSString *)cxcfile Cont:(NSString *)cxccont; //续写
- (BOOL)covercxcfile:(NSString *)cxcfile Cont:(NSString *)cxccont; //覆盖
- (BOOL)removecxcfile:(NSString *)cxcfile; //删除
- (BOOL)copycxcfile:(NSString *)cxcfile Cont:(NSString *)cxctofile; //复制
- (BOOL)movecxcfile:(NSString *)cxcfile Cont:(NSString *)cxctofile; //移动
- (NSArray *)condir:(NSString *)cxcfile; //列出目录
@end
