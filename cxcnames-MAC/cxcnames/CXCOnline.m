//
//  CXCOnline.m
//  cxcnames
//
//  Created by Terence Chen on 12-8-10.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "CXCOnline.h"

@implementation CXCOnline
- (void)startAsyConnection
{
    //第一步：创建URL
    NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
    //第二步：创建请求
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //第三步：发送请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}
//接收到服务器回应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"接收到服务器回应");
    self.receiveData = [[[NSMutableData alloc] init] autorelease];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收数据");
    [self.receiveData appendData:data];
}
//接收过程中出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error %@",[error localizedDescription]);
}
//成功接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"接收成功");
    NSString *str = [[NSString alloc] initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
}
@end
