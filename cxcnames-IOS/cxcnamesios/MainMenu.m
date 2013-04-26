//
//  MainMenu.m
//  cxcnamesios
//
//  Created by Terence Chen on 12-9-6.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "MainMenu.h"
#import "SettingMenu.h"

@interface MainMenu ()

@end

@implementation MainMenu
@synthesize txtarray = _txtarray, imgarray = _imgarray, infoarray = _infoarray;
- (void)dealloc
{
    [_infoarray release];
    [_txtarray release];
    [_imgarray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"霄霄抽签程序 for iOS";
    self.txtarray = [NSArray arrayWithObjects:@"程序设置",@"数据库管理",@"历史记录管理",@"关于与更新",nil];
    self.infoarray = [NSArray arrayWithObjects:@"更改动画速度、背景声音等各种参数。",@"管理要抽取的信息，可以自己创建数据库并携带库文件。",@"管理抽取的历史记录，可以使抽过的不再抽取。",@"查看软件作者和检查更新。",nil];
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"chengxushezhi" ofType:@"png"];
    UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"shujukuguanli" ofType:@"png"];
    UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"lishijiluguanli" ofType:@"png"];
    UIImage *img4 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"guanyuyugengxin" ofType:@"png"];
    UIImage *img5 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    self.imgarray = [NSArray arrayWithObjects: img2, img3, img4, img5, nil];
    [img2 release];[img3 release];[img4 release];[img5 release];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 960) style:UITableViewStyleGrouped]; //样式
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 100;
    [self.view addSubview:tableView];
    [tableView release];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(btnexit:)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; //Tableview有多少组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ //每组几行
    if (section == 0) {
        return 1;
    } else {
        return 4;
    }
}

#pragma mark - Table view delegate
//Tableview每行显示什么
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease]; //副标题样式
    }
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"CXC_BTN_H80_RED" ofType:@"png"];
    UIImage *bj1 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"CXC_BTN_H80_ORANGE" ofType:@"png"];
    UIImage *bj2 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor colorWithPatternImage:bj1];
            cell.textLabel.text = @"开始抽签";
            cell.detailTextLabel.text = @"点击进入抽签器 >>>";
            NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"kaishichouqian" ofType:@"png"];
            UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:imgPath];
            cell.imageView.image = img1;
            [img1 release];
            break;
        case 1:
            cell.backgroundColor = [UIColor colorWithPatternImage:bj2];
            cell.textLabel.text = [self.txtarray objectAtIndex:indexPath.row];
            cell.imageView.image = [self.imgarray objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [self.infoarray objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    [bj1 release]; [bj2 release];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue; //颜色
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //样式
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"点击这里进入抽签程序画面";
    } else {
        return @"应用程序选项";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return @"在进入之前，请先检查程序和数据库设置。";
    } else {
        return @"=== 已没有更多选项 ===";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ //点击
    NSLog(@"%d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //闪一下
    if (indexPath.section == 1 && indexPath.row == 0) {
        SettingMenu *aSettingMenu = [[SettingMenu alloc] init];
        aSettingMenu.title = @"抽签程序设置";
        [self.navigationController pushViewController:aSettingMenu animated:YES];
        [aSettingMenu release];
    }
    
    
}

- (void)btnexit:(id)sender
{
    exit(0);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
