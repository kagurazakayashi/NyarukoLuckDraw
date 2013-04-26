//
//  MainMenu.h
//  cxcnamesios
//
//  Created by Terence Chen on 12-9-6.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenu : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSArray *txtarray;
@property (nonatomic, retain) NSArray *imgarray;
@property (nonatomic, retain) NSArray *infoarray;
@end
