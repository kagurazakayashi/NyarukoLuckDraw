//
//  AppDelegate.h
//  cxcnames
//
//  Created by Terence Chen on 12-8-10.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, readwrite, assign) BOOL startstop;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSLayoutConstraint *btn_exit;
@property (assign) IBOutlet NSTextField *datalist;
@property (assign) IBOutlet NSButton *cdebug;
@property (assign) IBOutlet NSSlider *speed;
@property (assign) IBOutlet NSSlider *speed2;

@property (assign) IBOutlet NSButton *autosavehis;

@property (assign) IBOutlet NSTextField *datainfo;
@property (assign) IBOutlet NSTextField *dataitem;
@property (assign) IBOutlet NSTextField *status;
@property (assign) IBOutlet NSButton *nonrep;
@property (assign) IBOutlet NSButton *btnstart;
@property (assign) IBOutlet NSButton *btnstop;
@property (assign) IBOutlet NSButton *threadoption;
@property (assign) IBOutlet NSTextField *htylist;
@property (assign) IBOutlet NSTextField *hispuch;
@property (assign) IBOutlet NSButton *nohis;
//@property (assign) IBOutlet NSProgressIndicator *press;
@property (assign) IBOutlet NSTextField *datapuch;
@property (assign) IBOutlet NSPathControl *datapuchh;
@property (assign) IBOutlet NSBox *whatnew;
@property (assign) IBOutlet NSButton *chkupd;
@property (assign) IBOutlet NSTextField *whatnew2;
@property (assign) IBOutlet NSButton *showname2;
@property (assign) IBOutlet NSPathControl *hispuchh;
@property (nonatomic, retain) NSMutableData *receiveData;
@property (assign) IBOutlet NSTextField *showname;
@property (assign) IBOutlet NSTabView *mainframe;
@property (assign) IBOutlet AVAudioPlayer *player;
@property (assign) IBOutlet NSTextField *musicadd2;
@property (assign) IBOutlet NSPathControl *musicadd1;
@property (assign) IBOutlet NSSlider *volumeSlider;
@property (assign) IBOutlet NSSlider *scrubber;
@property (assign) IBOutlet NSSegmentedControl *setpz;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (assign) IBOutlet NSButton *mem;
@property (assign) IBOutlet NSSegmentedControl *musicset;

@end