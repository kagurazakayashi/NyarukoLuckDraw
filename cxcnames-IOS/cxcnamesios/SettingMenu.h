//
//  SettingMenu.h
//  cxcnamesios
//
//  Created by Terence Chen on 12-9-6.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingMenu : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSArray *txtarray1;
@property (nonatomic, retain) NSArray *imgarray1;
@property (nonatomic, retain) NSArray *infoarray1;
@property (nonatomic, retain) NSArray *txtarray2;
@property (nonatomic, retain) NSArray *imgarray2;
@property (nonatomic, retain) NSArray *infoarray2;
@property (nonatomic, retain) NSArray *txtarray3;
@property (nonatomic, retain) NSArray *imgarray3;
@property (nonatomic, retain) NSArray *infoarray3;
@end
