//
//  ViewController.m
//  namesipad
//
//  Created by Terence Chen on 12-8-25.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "ViewController.h"
#define kPicsize 998,685
#define kSETTOOL UIView *vv;\
switch (toolbar.selectedSegmentIndex) {\
    case 0:[[self.view viewWithTag:1] addSubview:setview];toolbar1.selectedSegmentIndex=0;vv = (UIView *)[self.view viewWithTag:10];break;\
    case 1:[[self.view viewWithTag:1] addSubview:dbview];toolbar2.selectedSegmentIndex=1;vv = (UIView *)[self.view viewWithTag:20];break;\
    case 2:[[self.view viewWithTag:1] addSubview:ccview];toolbar3.selectedSegmentIndex=2;vv = (UIView *)[self.view viewWithTag:30];break;\
    case 3:[[self.view viewWithTag:1] addSubview:hisview];toolbar4.selectedSegmentIndex=3;vv = (UIView *)[self.view viewWithTag:40];break;\
    case 4:[[self.view viewWithTag:1] addSubview:aboutview];toolbar5.selectedSegmentIndex=4;vv = (UIView *)[self.view viewWithTag:50];break;\
    default:break;}
#define kVV CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"opacity"];\
[ba setFromValue:[NSNumber numberWithInt:0]];\
[ba setToValue:[NSNumber numberWithInt:1]];\
[ba setDelegate:self];\
[ba setDuration:1];\
[vv.layer addAnimation:ba forKey:@"img-opacity"];\
CAKeyframeAnimation *key = [CAKeyframeAnimation animationWithKeyPath:@"position"];\
NSArray *pointArray = [NSArray arrayWithObjects:\
                       [NSValue valueWithCGPoint:CGPointMake(500, 0)],\
                       [NSValue valueWithCGPoint:CGPointMake(vv.bounds.size.width/2, vv.bounds.size.height/2)],nil];\
key.values = pointArray;\
[key setDuration:1];\
[vv.layer addAnimation:key forKey:@"img-position"];

@interface ViewController ()

@end

@implementation ViewController
@synthesize mainview;
@synthesize setview;
@synthesize abouttxt;
@synthesize aboutview;
@synthesize toolbar1;
@synthesize toolbar2;
@synthesize toolbar3;
@synthesize toolbar4;
@synthesize showname2;
@synthesize toolbar5;
@synthesize dbview;
@synthesize ccview;
@synthesize hisview;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self.view viewWithTag:1] addSubview:aboutview];
    self.abouttxt.text = @"    © 版权所有 绮光工作组 2000-2012\n    ♐ 程序编写：c\n    ♒ 筛选类算法：y\n\n    产品支持：\n    🌐 www.heartunlock.com/soft/ballot\n    📩 im@chenxiaochi.com\n\n    使用该产品，即同意本产品的许可协议。\n    如需检查新版本，请点击“检查更新”按钮或前往官方网站了解详情。\n\n    此版本建议在 iOS 5.1 及以上版本中使用（推荐配置），\n    并对 iOS 5 平台提供兼容支持（最低配置）。\n    如需 Windows / MAC OS X 版，请参阅官方网站。";
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"WT1" ofType:@"png"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgPath];
//    [img setSize:NSSizeFromCGSize(CGSizeMake(kPicsize))];
    [self.showname2 setImage:img forState:UIControlStateNormal];
//    [img release];
}
- (IBAction)toolbar1:(id)sender {
    UISegmentedControl *toolbar = (UISegmentedControl *) sender;
    if (toolbar.selectedSegmentIndex != 0)
    {
        kSETTOOL
        [[self.view viewWithTag:10] removeFromSuperview];
        kVV
    }
}

- (IBAction)toolbar2:(id)sender {
    UISegmentedControl *toolbar = (UISegmentedControl *) sender;
    if (toolbar.selectedSegmentIndex != 1)
    {
        kSETTOOL
        [[self.view viewWithTag:20] removeFromSuperview];
        kVV
    }
}

- (IBAction)toolbar3:(id)sender {
    UISegmentedControl *toolbar = (UISegmentedControl *) sender;
    if (toolbar.selectedSegmentIndex != 2)
    {
        kSETTOOL
        [[self.view viewWithTag:30] removeFromSuperview];
        kVV
    }
}

- (IBAction)toolbar4:(id)sender {
    UISegmentedControl *toolbar = (UISegmentedControl *) sender;
    if (toolbar.selectedSegmentIndex != 3)
    {
        kSETTOOL
        [[self.view viewWithTag:40] removeFromSuperview];
        kVV
    }
}

- (IBAction)toolbar5:(id)sender {
    UISegmentedControl *toolbar = (UISegmentedControl *) sender;
    if (toolbar.selectedSegmentIndex != 4)
    {
        kSETTOOL
        [[self.view viewWithTag:50] removeFromSuperview];
        kVV
    }
}

- (IBAction)btnexit:(id)sender {
    exit(0);
}


- (void)tosetview
{
    
}

- (void)viewDidUnload
{
    [self setMainview:nil];
    [self setAbouttxt:nil];
    [self setSetview:nil];
    [self setAboutview:nil];
    [self setAbouttxt:nil];
    [self setDbview:nil];
    [self setCcview:nil];
    [self setHisview:nil];
    [self setToolbar1:nil];
    [self setToolbar2:nil];
    [self setToolbar3:nil];
    [self setToolbar4:nil];
    [self setToolbar5:nil];
    [self setShowname2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
