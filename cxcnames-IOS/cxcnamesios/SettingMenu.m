//
//  SettingMenu.m
//  cxcnamesios
//
//  Created by Terence Chen on 12-9-6.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "SettingMenu.h"

@interface SettingMenu ()

@end

@implementation SettingMenu
@synthesize txtarray1 = _txtarray1, imgarray1 = _imgarray1, infoarray1 = _infoarray1,
txtarray2 = _txtarray2, imgarray2 = _imgarray2, infoarray2 = _infoarray2,
txtarray3 = _txtarray3, imgarray3 = _imgarray3, infoarray3 = _infoarray3;
- (void)dealloc
{
    [_infoarray1 release];    [_txtarray1 release];    [_imgarray1 release];
    [_infoarray2 release];    [_txtarray2 release];    [_imgarray2 release];
    [_infoarray3 release];    [_txtarray3 release];    [_imgarray3 release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.txtarray1 = [NSArray arrayWithObjects:@"抽取运行速度",@"动画运行速度",@"更换动画的主题",nil];
    self.infoarray1 = [NSArray arrayWithObjects:@"修改文字跳动的速度。",@"修改背景动画的速度。",@"更改画面样式。",nil];
    self.txtarray2 = [NSArray arrayWithObjects:@"已有项目不再抽取",@"使用多线程",@"动画性能优化",nil];
    self.infoarray2 = [NSArray arrayWithObjects:@"将自动删除历史记录中的重复条目。但因为一个Bug建议手工删除。",@"建议开启，关闭此项将禁用动画效果。",@"移动设备请不要关闭此项，关闭会对移动设备造成过大的负载！",nil];
    self.txtarray3 = [NSArray arrayWithObjects:@"禁用背景音乐",@"使用默认背景音乐",@"使用导入的MP3作为背景音乐",@"停止当前背景音乐播放",@"音乐播放音量",@"播放起始位置",nil];
    self.infoarray3 = [NSArray arrayWithObjects:@"关闭背景音乐，可以提高一些性能。",@"设置为默认的背景音乐",@"使用iToos等软件将音乐导入本软件的文档文件夹里，然后在这里输入音乐名。",@"停止正在出声的背景音乐和预览播放。",@"控制背景音乐的播放音量。",@"控制背景音乐将要从哪里开始播放",nil];
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"chouqusudu" ofType:@"png"];
    UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"beijingsudu" ofType:@"png"];
    UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"huamianyangshi" ofType:@"png"];
    UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    self.imgarray1 = [NSArray arrayWithObjects: img1, img2, img3, nil];
    [img1 release];[img2 release];[img3 release];
    imgPath = [[NSBundle mainBundle] pathForResource:@"yiyouxiangmu" ofType:@"png"];
    UIImage *img4 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"shiyongduoxiancheng" ofType:@"png"];
    UIImage *img5 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"donghuaxingnengyouhua" ofType:@"png"];
    UIImage *img6 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    self.imgarray2 = [NSArray arrayWithObjects: img4, img5, img6, nil];
    [img4 release];[img5 release];[img6 release];
    imgPath = [[NSBundle mainBundle] pathForResource:@"guanbi" ofType:@"png"];
    UIImage *img7 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"morenyinyue" ofType:@"png"];
    UIImage *img8 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"yinyue" ofType:@"png"];
    UIImage *img9 = [[UIImage alloc] initWithContentsOfFile:imgPath];
//    imgPath = [[NSBundle mainBundle] pathForResource:@"guanbi" ofType:@"png"];
//    UIImage *img10 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"yinliang" ofType:@"png"];
    UIImage *img11 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    imgPath = [[NSBundle mainBundle] pathForResource:@"qishiweizhi" ofType:@"png"];
    UIImage *img12 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    self.imgarray3 = [NSArray arrayWithObjects: img7, img8, img9, img7, img11, img12 , nil];
    [img7 release];[img8 release];[img9 release];[img11 release];[img12 release];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 960) style:UITableViewStyleGrouped]; //样式
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 100;
    [self.view addSubview:tableView];
    [tableView release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4; //Tableview有多少组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ //每组几行
    if (section == 2) {
        return 6;
    } else if (section == 3){
        return 1;
    } else {
        return 3;
    }
    switch (section) {
        case 0: return 3; break;
        case 1: return 3; break;
        case 2: return 5; break;
        case 3: return 1; break;
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
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"CXC_BTN_H80_ORANGE" ofType:@"png"];
    UIImage *bj = [[UIImage alloc] initWithContentsOfFile:imgPath];
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor colorWithPatternImage:bj];
            cell.textLabel.text = [self.txtarray1 objectAtIndex:indexPath.row];
            cell.imageView.image = [self.imgarray1 objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [self.infoarray1 objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //样式
            break;
        case 1:
            cell.backgroundColor = [UIColor colorWithPatternImage:bj];
            cell.textLabel.text = [self.txtarray2 objectAtIndex:indexPath.row];
            cell.imageView.image = [self.imgarray2 objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [self.infoarray2 objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 2:
            cell.backgroundColor = [UIColor colorWithPatternImage:bj];
            cell.textLabel.text = [self.txtarray3 objectAtIndex:indexPath.row];
            cell.imageView.image = [self.imgarray3 objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [self.infoarray3 objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //样式
            if (indexPath.row < 3) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        case 3:
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.text = @"算法模拟";
            cell.detailTextLabel.text = @"（开发用）";
            NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"MB_0011_apple" ofType:@"png"];
            UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:imgPath];
            cell.imageView.image = img1;
            [img1 release];
            break;
        default:
            break;
    }
    [bj release];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue; //颜色
    
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
    switch (section) {
        case 0: return @"动画效果选项"; break;
        case 1: return @"规则和性能选项"; break;
        case 2: return @"背景音乐选项"; break;
        case 3: return @"调试"; break;
        default: return @"扩展插件"; break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return @"=== 已没有更多选项 ===";
    } else {
        return nil;
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
