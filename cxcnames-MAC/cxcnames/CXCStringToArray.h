//
//  CXCStringToArray.h
//  cxcnames
//
//  Created by Terence Chen on 12-8-11.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCStringToArray : NSObject
- (NSArray *)StringToArray:(NSString *)string;
- (NSString *)ArrayToString:(NSArray *)string;
@end
