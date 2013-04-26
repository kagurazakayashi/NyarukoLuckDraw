//
//  CXCOnline.h
//  cxcnames
//
//  Created by Terence Chen on 12-8-10.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCOnline : NSObject
@property (nonatomic, retain) NSMutableData *receiveData;
//异步链接方法
- (void)startAsyConnection;
@end
