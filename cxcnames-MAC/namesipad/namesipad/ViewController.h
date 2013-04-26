//
//  ViewController.h
//  namesipad
//
//  Created by Terence Chen on 12-8-25.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIView *setview;
@property (weak, nonatomic) IBOutlet UILabel *abouttxt;
@property (strong, nonatomic) IBOutlet UIView *dbview;
@property (strong, nonatomic) IBOutlet UIView *ccview;
@property (strong, nonatomic) IBOutlet UIView *hisview;
@property (strong, nonatomic) IBOutlet UIView *aboutview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toolbar1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toolbar2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toolbar3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toolbar4;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toolbar5;
@property (weak, nonatomic) IBOutlet UIButton *showname2;
@end
