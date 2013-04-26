//
//  AppDelegate.m
//  cxcnames
//
//  Created by Terence Chen on 12-8-10.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "CXCFileIO.h"
#import "CXCFileExists.h"
#import "CXCStringToArray.h"
#import "CXCFilter.h"
#define kPicsize 998,685
#define kUPDURL "http://www.heartunlock.com/soft/ballot/update.txt"
@implementation AppDelegate
@synthesize mem;
@synthesize musicset;
@synthesize musicadd2;
@synthesize musicadd1;
@synthesize volumeSlider;
@synthesize scrubber;
@synthesize setpz;
@synthesize receiveData = _receiveData;
@synthesize showname;
@synthesize mainframe;
@synthesize btn_exit;
@synthesize datalist;
@synthesize cdebug;
@synthesize speed;
@synthesize speed2;
@synthesize autosavehis;
@synthesize datainfo;
@synthesize dataitem;
@synthesize datapuch;
@synthesize datapuchh;
@synthesize whatnew;
@synthesize chkupd;
@synthesize whatnew2;
@synthesize showname2;
@synthesize status;
@synthesize nonrep;
@synthesize btnstart;
@synthesize btnstop;
@synthesize threadoption;
@synthesize htylist;
@synthesize hispuch;
@synthesize nohis;
//@synthesize press;
@synthesize hispuchh;
@synthesize startstop = _startstop;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _startstop = FALSE;
    htylist.stringValue = @"";
    
    datapuch.stringValue = [NSString stringWithFormat:@"%@/Documents/ballot_data.cxc",NSHomeDirectory()];
    NSLog(@"datapuch.stringValue = %@",[datapuch stringValue]);
    [self updatedatapuchh];
    hispuch.stringValue = [NSString stringWithFormat:@"%@/Documents/ballot_history.cxc",NSHomeDirectory()];
    [self updatehispuchh];
    musicadd1.stringValue = [NSString stringWithFormat:@"%@/Documents/ballot_music.mp3",NSHomeDirectory()];
    musicadd2.stringValue = musicadd1.stringValue;
//    [self setValue:datapuch.stringValue forKey:@"jt1"];
//    [self setValue:hispuch.stringValue forKey:@"jt2"];
//    [self addObserver:self forKeyPath:@"jt1" options:NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self forKeyPath:@"jt2" options:NSKeyValueObservingOptionNew context:nil];
    NSMutableString *username = [NSMutableString stringWithString:NSHomeDirectory()];
    [username deleteCharactersInRange:NSMakeRange(0, 7)];
//    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"WT1" ofType:@"png"];    NSImage *img = [[NSImage alloc] initWithContentsOfFile:imgPath];
//    [img setSize:NSSizeFromCGSize(CGSizeMake(kPicsize))];
//    [self.showname setBackgroundColor:[NSColor colorWithPatternImage:img]];
    [self memimg];
    [self.showname2 setImage:[self.imageArray objectAtIndex:1]];
    //    [self.showname2 setTitle:[NSString stringWithFormat:@"点击这里\n开始/停止"]];
//    [self setButtonColor:self.showname2 andColor:[NSColor yellowColor]];
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(backimgact) userInfo:nil repeats:YES];
//    [img release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"baijin" ofType:@"ep3"];
    NSURL *url = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error)
    {
        status.stringValue = [NSString stringWithFormat:@"错误：音频文件播放失败（%@）。",[error localizedDescription]];
    }
    if (self.player) { self.player.volume = volumeSlider.floatValue; }
    self.player.currentTime = [scrubber doubleValue] * self.player.duration;
    [self.player prepareToPlay];
    [self dataread];
    status.stringValue = [NSString stringWithFormat:@"欢迎您使用，%@。程序已准备就绪。",username];
    NSLog(@"霄霄的程序初始化完成。");
    // Insert code here to initialize your application
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    hispuchh.stringValue = [change valueForKey:@"jt2"];
//    datapuchh.stringValue = [change valueForKey:@"jt1"];
//}
//- (void)setButtonColor:(NSButton *)button andColor:(NSColor *)color {
//    int fontSize = 100;
//    NSFont *font = [NSFont systemFontOfSize:fontSize];
//    NSDictionary * attrs = [NSDictionary dictionaryWithObjectsAndKeys:font,
//                            NSFontAttributeName,
//                            color,
//                            NSForegroundColorAttributeName,
//                            nil];
//    
//    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:[button title] attributes:attrs];
//    //[attributedString setAlignment:NSCenterTextAlignment range:NSMakeRange(0, [attributedString length])];
//    [button setAttributedTitle:attributedString];
//    [attributedString release];
//}
- (IBAction)btn_exit:(id)sender {
    NSLog(@"执行退出命令。");
    exit(0);
}
- (IBAction)cdebug:(id)sender {
    [cdebug setEnabled:FALSE];
    int a=0,b=0,c=0,d=0,e=0;
    CXCStringToArray *CSTA = [[CXCStringToArray alloc] init];
    NSArray *ar = [CSTA StringToArray:@"1，2，3，4，5"];
    NSString *ar2 = [ar objectAtIndex:rand()%[ar count]];
    for (NSInteger i = 0; i < 100; i++) {
        ar2 = [ar objectAtIndex:rand()%[ar count]];
        if ( [ar2 intValue] == 1) { a++; }
        else  if ( [ar2 intValue] == 2) { b++; }
        else  if ( [ar2 intValue] == 3) { c++; }
        else  if ( [ar2 intValue] == 4) { d++; }
        else  if ( [ar2 intValue] == 5) { e++; }
        else { status.stringValue = @"ERROR"; }
    }    
    status.stringValue = [NSString stringWithFormat:@"本次算法模拟：A的概率%d%%，B的概率%d%%，C的概率%d%%，D的概率%d%%，E的概率%d%%。",a,b,c,d,e];
    [cdebug setEnabled:TRUE];
}
- (void)updatedatapuchh
{
    datapuchh.stringValue = [datapuch stringValue];
//    CXCFileExists *CFE = [[CXCFileExists alloc] init];
//    if ([CFE existscxcfile:[datapuch stringValue]] && ([[datapuch stringValue] length] != 0)) {
//        NSLog(@"更新数据地址栏，文件存在，更新为\nfile://%@",[datapuch stringValue]);
//        datapuchh.stringValue = [NSString stringWithFormat:@"file://localhost%@",[datapuch stringValue]];
//    } else {
//        datapuchh.stringValue = [datapuch stringValue];
//    }
}
- (void)updatehispuchh
{
    hispuchh.stringValue = [hispuch stringValue];
//    CXCFileExists *CFE = [[CXCFileExists alloc] init];
//    if ([CFE existscxcfile:[hispuch stringValue]] && ([[hispuch stringValue] length] != 0)) {
//        NSLog(@"更新历史地址栏，文件存在，更新为\nfile://localhost%@",[hispuch stringValue]);
//        hispuchh.stringValue = [NSString stringWithFormat:@"file://localhost%@",[hispuch stringValue]];
//    } else {
//        hispuchh.stringValue = [hispuch stringValue];
//    }
}
- (void)dataread
{
    status.stringValue = @"正在读取数据库……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[datapuch stringValue]])
    {
        CXCStringToArray *CSTA = [[CXCStringToArray alloc] init];
        datalist.stringValue = [CFI readcxcfile:[datapuch stringValue]];
        NSArray *it = [CSTA StringToArray:[datalist stringValue]];
        dataitem.stringValue = [NSString stringWithFormat:@"%lu",it.count-1];
        datainfo.stringValue = [it objectAtIndex:0];
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"%@",[datalist stringValue]];
        [str deleteCharactersInRange:NSMakeRange(0, [[it objectAtIndex:0] length]+1)];
        
        datalist.stringValue = str;
        status.stringValue = @"数据库载入完毕。";
    } else {
        status.stringValue = @"[错误]要读取的数据库文件不存在，请检查文件路径。";
    }
}
- (IBAction)dataload:(id)sender {
    [self dataread];
}
- (IBAction)hisload:(id)sender {
    status.stringValue = @"正在读取历史记录文件……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[hispuch stringValue]])
    {
        htylist.stringValue = [CFI readcxcfile:[hispuch stringValue]];
        status.stringValue = @"历史记录文件载入完毕。";
    } else {
        status.stringValue = @"[错误]要读取的历史记录文件文件不存在，请检查文件路径。";
    }
}

- (IBAction)datasave:(id)sender {
    status.stringValue = @"正在保存数据库……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[datapuch stringValue]])
    {
        [CFI removecxcfile:[datapuch stringValue]];
        
        if ([CFI covercxcfile:[datapuch stringValue] Cont:[NSString stringWithFormat:@"%@，%@",[datainfo stringValue],[datalist stringValue]]]) {
            status.stringValue = @"数据库保存完毕，覆盖原文件。";
            [self dataread];
        } else {
            status.stringValue = @"[错误]数据库保存失败，请确保源文件是可以替换的。";
        }
    } else {
        if ([CFI covercxcfile:[datapuch stringValue] Cont:[NSString stringWithFormat:@"%@，%@",[datainfo stringValue],[datalist stringValue]]]) {
            status.stringValue = @"数据库保存完毕，创建了新文件。";
            [self dataread];
        } else {
            status.stringValue = @"[错误]数据库保存失败，请确保源文件目录是可以写入的。";
        }
    }
}
- (void)htysave2 {
    status.stringValue = @"正在保存历史记录文件……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[hispuch stringValue]])
    {
        [CFI removecxcfile:[hispuch stringValue]];
        
        if ([CFI covercxcfile:[hispuch stringValue] Cont:[htylist stringValue]]) {
            status.stringValue = @"历史记录文件保存完毕，覆盖原文件。";
        } else {
            status.stringValue = @"[错误]历史记录文件保存失败，请确保源文件是可以替换的。";
        }
    } else {
        if ([CFI covercxcfile:[hispuch stringValue] Cont:[htylist stringValue]]) {
            status.stringValue = @"历史记录文件保存完毕，创建了新文件。";
        } else {
            status.stringValue = @"[错误]历史记录文件保存失败，请确保源文件目录是可以写入的。";
        }
    }
}
- (IBAction)htysave:(id)sender {
    [self htysave2];
}

- (IBAction)datanew:(id)sender {
    status.stringValue = @"正在创建新数据库……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[datapuch stringValue]])
    {
        status.stringValue = @"[错误]要创建的新文件已经在文件夹里重名，请换个文件名。";
    } else {
        if ([CFI covercxcfile:[datapuch stringValue] Cont:@"未命名数据库，示例条目A，示例条目B，示例条目C，示例条目D，示例条目E，示例条目F，示例条目G，示例条目H，示例条目I，示例条目J，示例条目K，示例条目L，示例条目M，示例条目N，示例条目O，示例条目P，示例条目Q，示例条目R，示例条目S，示例条目T，示例条目U，示例条目V，示例条目W，示例条目X，示例条目Y，示例条目Z"]) {
            status.stringValue = @"创建新数据库文件完毕。";
            [self dataread];
        } else {
            status.stringValue = @"[错误]数据库新建失败，请确保源文件目录是可以写入的。";
        }
    }
}
- (IBAction)hisnew:(id)sender {
    status.stringValue = @"正在创建新历史记录文件……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[hispuch stringValue]])
    {
        status.stringValue = @"[错误]要创建的新文件已经在文件夹里重名，请换个文件名。";
    } else {
        if ([CFI covercxcfile:[hispuch stringValue] Cont:@""]) {
            htylist.stringValue = @"";
            status.stringValue = @"创建新历史记录文件完毕。";
        } else {
            status.stringValue = @"[错误]历史记录文件新建失败，请确保源文件目录是可以写入的。";
        }
    }
}

- (IBAction)datadel:(id)sender {
    status.stringValue = @"正在删除数据库……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[datapuch stringValue]])
    {
        if ([CFI removecxcfile:[datapuch stringValue]]) {
            status.stringValue = @"删除数据库完毕。";
        } else {
            status.stringValue = @"[错误]数据库删除失败，请确保源文件目录是可以写入的。";
        }
    } else {
        status.stringValue = @"[提示]指定的数据库文件不存在，无需删除。";
    }
}
- (IBAction)hisdel:(id)sender {
    status.stringValue = @"正在删除历史记录文件……";
    CXCFileExists *CFE = [[CXCFileExists alloc] init];
    CXCFileIO *CFI = [[CXCFileIO alloc] init];
    if ([CFE existscxcfile:[hispuch stringValue]])
    {
        if ([CFI removecxcfile:[hispuch stringValue]]) {
            status.stringValue = @"删除历史记录文件完毕。";
        } else {
            status.stringValue = @"[错误]历史记录文件删除失败，请确保源文件目录是可以写入的。";
        }
    } else {
        status.stringValue = @"[提示]指定的历史记录文件文件不存在，无需删除。";
    }
}

- (IBAction)datadelre:(id)sender {
    status.stringValue = @"正在清除数据库中的重复项……";
    CXCStringToArray *CSTA = [[CXCStringToArray alloc] init];
    CXCFilter *CF = [[CXCFilter alloc] init];
    NSArray *it = [CSTA StringToArray:[datalist stringValue]];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:it];
//    NSUInteger add = 0;
    datalist.stringValue = [CSTA ArrayToString:[CF delRepeat:arr]];
//    if (add == 0)
//    { status.stringValue = @"[提示]没有找到重复的条目。";
//    } else {
//      status.stringValue = [NSString stringWithFormat:@"[提示]找到了 %lu 个重复条目，已经删除多余的条目。",add];
//    }
    status.stringValue = @"已去除重复条目。";
}

- (void)memimg
{
    self.imageArray = [NSArray arrayWithObjects:
                  [NSImage imageNamed:@"WT1.png"],
                  [NSImage imageNamed:@"WT2.png"],
                  [NSImage imageNamed:@"WT3.png"],
                  [NSImage imageNamed:@"WT4.png"],
                  [NSImage imageNamed:@"WT5.png"], nil];
    for (NSInteger i = 0; i < 5; i++) {
        [[self.imageArray objectAtIndex:i] setSize:NSSizeFromCGSize(CGSizeMake(kPicsize))];
        self.status.stringValue = [NSString stringWithFormat:@"缓存数据：%lu0%%。",(i+1)*2];
    }
}

- (void)doAction:(id)sender
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"WT1" ofType:@"png"];
    for (int i = 1; 1 ; i++)
    {
        if ([speed2 intValue] < 500000) {
            usleep(500000 - [speed2 intValue]);
        }
        if ([mem intValue] == 1) {
            [self.showname2 setImage:[self.imageArray objectAtIndex:i-1]];
        } else {
            imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"WT%d",i] ofType:@"png"];
            NSImage *img = [[NSImage alloc] initWithContentsOfFile:imgPath];
            [img setSize:NSSizeFromCGSize(CGSizeMake(kPicsize))];
            [self.showname2 setImage:img];
            [img release];
        }
        if (_startstop == FALSE) {
            break;
        } else if (i == 5) {
            i = 0;
        }
    }
    [pool release];
}

- (void)start
{
    CXCStringToArray *CSTA = [[CXCStringToArray alloc] init];
    NSArray *it = [CSTA StringToArray:[datalist stringValue]];
    NSArray *hs = [CSTA StringToArray:[htylist stringValue]];
    BOOL chongfu = FALSE;
//    NSUInteger ps = 0;
//    [press setIndeterminate:FALSE];
    while (1) {
//        ps++;
//        [press setDoubleValue: 100];
//        if (ps == 100) {
//            ps = 0;
//        }
        if ([speed intValue] < 100000) {
            usleep(100000 - [speed intValue]);
        }
        if ([nohis intValue] == 1) {
            status.stringValue = @"正在过滤历史记录中重复的条目……";
            CXCFilter *CF = [[CXCFilter alloc] init];
            NSMutableArray *hss=[NSMutableArray arrayWithArray:hs];
            hss = [CF delRepeat:hss];
            htylist.stringValue = [CSTA ArrayToString:hss];
            NSMutableArray *itt=[NSMutableArray arrayWithArray:it];
            
            status.stringValue = @"正在过滤历史记录中已有的条目……";
            for (NSInteger i=0; i<[itt count]; i++) {
                for (NSInteger j=0; j<[hss count]; j++) {
                    BOOL bj=[[itt objectAtIndex:i] isEqualToString:[hss objectAtIndex:j]];
                    if (bj == 1) {
                        [itt removeObjectAtIndex:i];
                    }
                }
            }
//            for (NSString *iff in itt) {
//                NSLog(@"=====%@=====",iff);
//            }
            if ([itt count] == 0)
            {
                status.stringValue = @"所有的人都已经点过了。请清除历史记录或关闭重复抽签过滤再试。";
                chongfu = FALSE;
//                [press setDoubleValue: (double)0];
//                [press setIndeterminate:TRUE];
                _startstop = FALSE;
                [btnstop setEnabled:FALSE];
                [btnstart setEnabled:TRUE];
                break;
            }
            showname.stringValue = [itt objectAtIndex:rand()%[itt count]];
//            [self.showname2 setTitle:itt[rand()%[itt count]]];
        } else {
            showname.stringValue = [it objectAtIndex:rand()%[it count]];
//            [self.showname2 setTitle:it[rand()%[it count]]];
        }
        if (_startstop == FALSE) {
            if ([[htylist stringValue]length] == 0) {
//                htylist.stringValue = [showname stringValue];
                htylist.stringValue = [showname stringValue];
            } else {
//                htylist.stringValue = [NSString stringWithFormat:@"%@，%@", [htylist stringValue], [showname stringValue]];
                htylist.stringValue = [NSString stringWithFormat:@"%@，%@", [htylist stringValue], [showname stringValue]];
            }
            
            if ([autosavehis intValue] == 1)
            {
                [self htysave2];
            }
            chongfu = FALSE;
//            [press setDoubleValue: (double)0];
            //            [press setIndeterminate:TRUE];
            [self.player stop];
            self.player.currentTime = 0;
            status.stringValue = @" ◼ 抽取已停止。点击抽取框空白区域或按空格键重新开始抽取。";
            break;
        }
    }
}
- (IBAction)btnstart:(id)sender { //弃用
    [btnstart setEnabled:FALSE];
    _startstop = TRUE;
    status.stringValue = @" ▶ 抽取进行中。点击抽取框空白区域或按空格键停止。";
    if (self.musicset.selectedSegment == 0) { [self.player pause]; self.player.currentTime = [scrubber doubleValue] * self.player.duration; [self.player play]; }
    if ([threadoption intValue] == 1)
    {
        //[NSThread detachNewThreadSelector:@selector(doSomething:) toTarget:self withObject:nil];
        NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething:) object:nil];
        [myThread start];
        [btnstop setEnabled:TRUE];
    } else {
        //线程1
        _startstop = FALSE;
        [self start];
        [btnstart setEnabled:TRUE];
    }
}
- (void) doSomething:(id)sender
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    //线程2
    [self start];
    [pool release];
}

- (IBAction)btnstop:(id)sender { //弃用
    status.stringValue = @"抽取正在停止……";
    [btnstop setEnabled:FALSE];
    _startstop = FALSE;
    [btnstart setEnabled:TRUE];
}



- (IBAction)showname2:(id)sender {
    if (_startstop == FALSE) {
        [btnstart setEnabled:FALSE];
        _startstop = TRUE;
        status.stringValue = @" ▶ 抽取进行中。点击抽取框空白区域或按空格键停止。";
        if (self.musicset.selectedSegment != 0) { [self.player pause]; self.player.currentTime = [scrubber doubleValue] * self.player.duration; [self.player play]; }
        if ([threadoption intValue] == 1)
        {
            //[NSThread detachNewThreadSelector:@selector(doSomething:) toTarget:self withObject:nil];
            NSThread* myAction = [[NSThread alloc] initWithTarget:self selector:@selector(doAction:) object:nil];
            NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething:) object:nil];
            [myAction start];
            [myThread start];
            [btnstop setEnabled:TRUE];
        } else {
            //线程1
            _startstop = FALSE;
            [self start];
            [btnstart setEnabled:TRUE];
        }
    }
    else
    {
        status.stringValue = @"抽取正在停止……";
        [btnstop setEnabled:FALSE];
        _startstop = FALSE;
        [btnstart setEnabled:TRUE];
    }
}


- (IBAction)hiscls:(id)sender {
    htylist.stringValue = @"";
    status.stringValue = @"已清除历史记录。";
}

- (IBAction)musicadd1:(id)sender {
    musicadd1.stringValue = musicadd2.stringValue;
    [musicadd2 setHidden:FALSE];
    [musicadd1 setHidden:TRUE];
}
- (IBAction)musicadd2:(id)sender {
    musicadd2.stringValue = musicadd1.stringValue;
    [musicadd2 setHidden:TRUE];
    [musicadd1 setHidden:FALSE];
}


- (IBAction)hispuch:(id)sender {
    [self updatehispuchh];
    [hispuchh setHidden:FALSE];
    [hispuch setHidden:TRUE];
}
- (IBAction)hispuchh:(id)sender {
    [hispuchh setHidden:TRUE];
    [hispuch setHidden:FALSE];
}
- (IBAction)datapuch:(id)sender {
    [self updatedatapuchh];
    [datapuchh setHidden:FALSE];
    [datapuch setHidden:TRUE];
}
- (IBAction)datapuchh:(id)sender {
    [datapuchh setHidden:TRUE];
    [datapuch setHidden:FALSE];
}
- (IBAction)chkupd:(id)sender {
    if (whatnew.isHidden == TRUE)
    {
        [chkupd setEnabled:FALSE];
        whatnew2.stringValue = @"正在后台检查新版本，\n请稍候…";
        [whatnew setHidden:FALSE];
        [self startAsyConnection];
    } else {
        [whatnew setHidden:TRUE];
    }
}
- (void)startAsyConnection
{
    //第一步：创建URL
    NSURL *url = [NSURL URLWithString:@kUPDURL];
    //第二步：创建请求
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
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
    whatnew2.stringValue = [NSString stringWithFormat:@"%@..",[whatnew2 stringValue]];
    [self.receiveData appendData:data];
}
//接收过程中出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error %@",[error localizedDescription]);
    whatnew2.stringValue = [NSString stringWithFormat:@"检查更新发生错误！\n请检查：\n - 互联网连接是否正常？\n - 程序版本是否过旧？\n - 详细问题原因：%@",[error localizedDescription]];
    [chkupd setEnabled:TRUE];
}
//成功接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"接收成功");
    NSString *str = [[NSString alloc] initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    whatnew2.stringValue = str;
    [chkupd setEnabled:TRUE];
}
- (IBAction)hideshow:(id)sender {
    [self.showname setHidden:!self.showname.isHidden];
    [self.showname2 setHidden:!self.showname2.isHidden];
}
//- (IBAction)applymusic:(id)sender {
//    [self appmusic];
//}

- (void)appmusic
{
    [self.player stop];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"mp3"];
    if (self.musicset.selectedSegment == 0) {
        self.status.stringValue = @"背景音乐已禁用。";
    } else if (self.musicset.selectedSegment == 1){
        path = [[NSBundle mainBundle] pathForResource:@"baijin" ofType:@"ep3"];
        self.status.stringValue = @"背景音乐已设置为默认。";
    } else if (self.musicset.selectedSegment == 2){
        CXCFileExists *CFE = [[CXCFileExists alloc] init];
        if ([CFE existscxcfile:[musicadd2 stringValue]])
        {
            path = [[NSBundle mainBundle] pathForResource:self.musicadd2.stringValue ofType:@"mp3"];
            self.status.stringValue = [NSString stringWithFormat:@"背景音乐已设置为：%@",self.musicadd2.stringValue];
        } else {
            self.status.stringValue = @"错误：路径中的MP3文件不存在！（注：只支持MP3音频格式）";
            path = [[NSBundle mainBundle] pathForResource:@"baijin" ofType:@"ep3"];
            self.musicset.selectedSegment = 1;
        }
    }
    NSURL *url = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error)
    {
        status.stringValue = [NSString stringWithFormat:@"错误：音频文件播放失败（%@）。",[error localizedDescription]];
    }
    [self.player prepareToPlay];
}

- (IBAction)volumeSlider:(id)sender {
    if (self.player) { self.player.volume = volumeSlider.floatValue; [self.player play];}
}
- (IBAction)scrubber:(id)sender {
    [self.player pause]; self.player.currentTime = [scrubber doubleValue] * self.player.duration; [self.player play];
}
- (IBAction)stoppre:(id)sender {
    [self.player stop];
}
- (IBAction)setpz:(id)sender {
    NSSegmentedControl *setpz2 = (NSSegmentedControl *)sender;
    switch (setpz2.selectedSegment) {
        case 0:
            speed.intValue = 0;
            speed2.intValue = 0;
            threadoption.intValue = 0;
            self.musicset.selectedSegment = 0;
            break;
        case 1:
            speed.intValue = 10000;
            speed2.intValue = 200000;
            threadoption.intValue = 1;
            self.musicset.selectedSegment = 1;
            break;
        case 2:
            speed.intValue = 45000;
            speed2.intValue = 350000;
            threadoption.intValue = 1;
            self.musicset.selectedSegment = 1;
            break;
        case 3:
            speed.intValue = 55000;
            speed2.intValue = 450000;
            threadoption.intValue = 1;
            self.musicset.selectedSegment = 1;
            break;
        case 4:
            speed.intValue = 99000;
            speed2.intValue = 499000;
            threadoption.intValue = 1;
            self.musicset.selectedSegment = 1;
            break;
        default:
            break;
    }
}
- (IBAction)mem:(id)sender {
    NSButton *mm = (NSButton *)sender;
    if ([mm intValue] == 1) {
        [self memimg];
    } else {
        self.imageArray = nil;
        self.status.stringValue = @"缓存的资源已从内存中释放。";
    }
}
- (IBAction)musicset:(id)sender {
    [self appmusic];
}



@end
//@interface myThread:NSThread
//@implementation myThread
