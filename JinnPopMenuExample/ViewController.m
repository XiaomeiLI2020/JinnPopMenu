//
//  ViewController.m
//  JinnPopMenuExample
//
//  Created by jinnchang on 16/8/23.
//  Copyright © 2016年 Jinn Chang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "JinnPopMenu.h"

#define COLOR_ITEM          [UIColor whiteColor]
#define COLOR_ITEM_SELECTED [UIColor yellowColor]
#define COLOR_BACKGROUND    [UIColor darkGrayColor]

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, JinnPopMenuDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuImages;

@end

@implementation ViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self createViews];
}

#pragma mark - Init

- (void)setup
{
    self.titles = @[@[@"默认菜单", @"example00"],
                    @[@"选项菜单", @"example01"],
                    @[@"纯图标菜单", @"example02"],
                    @[@"纯文本菜单", @"example03"],
                    @[@"毛玻璃背景", @"example04"],
                    @[@"局部背景", @"example05"],
                    @[@"无动画", @"example06"],
                    @[@"淡入动画", @"example07"],
                    @[@"每行自定义菜单个数", @"example08"],
                    @[@"菜单纵向偏移", @"example09"],
                    @[@"基于视图弹出菜单", @"example10"]];
    
    self.menuTitles = @[@"删除", @"下载", @"编辑", @"信息", @"搜索", @"分享"];
    self.menuImages = @[@[@"delete", @"delete_selected"],
                        @[@"download", @"download_selected"],
                        @[@"edit", @"edit_selected"],
                        @[@"message", @"message_selected"],
                        @[@"search", @"search_selected"],
                        @[@"share", @"share_selected"]];
}

- (void)createViews
{
    self.title = @"JinnPopMenu";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setShowsHorizontalScrollIndicator:NO];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Examples

- (void)example00
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu show];
}

- (void)example01
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                selectedTitle:self.menuTitles[i]
                                                           selectedTitleColor:COLOR_ITEM_SELECTED
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]
                                                                 selectedIcon:[UIImage imageNamed:self.menuImages[i][1]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setMode:JinnPopMenuModeSegmentedControl];
    [popMenu setShouldHideWhenBackgroundTapped:YES];
    [popMenu setShouldHideWhenItemSelected:NO];
    [popMenu show];
    [popMenu selectItemAtIndex:0];
}

- (void)example02
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithIcon:[UIImage imageNamed:self.menuImages[i][0]]];
        [popMenuItem setBackgroundColor:[UIColor grayColor]];
        [popMenuItem.layer setCornerRadius:36];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setItemSize:CGSizeMake(72, 72)];
    [popMenu show];
}

- (void)example03
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i] titleColor:COLOR_BACKGROUND];
        [popMenuItem setBackgroundColor:COLOR_ITEM];
        [popMenuItem.layer setCornerRadius:36];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setItemSize:CGSizeMake(72, 72)];
    [popMenu show];
}

- (void)example04
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setBackgroundStyle:JinnPopMenuStyleBlur];
    [popMenu show];
}

- (void)example05
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setBezelStyle:JinnPopMenuStyleBlur];
    [popMenu setMargin:CGPointMake(20, 20)];
    [popMenu setShouldHideWhenBackgroundTapped:YES];
    [popMenu show];
    [popMenu.backgroundView setBackgroundColor:[UIColor clearColor]];
    [popMenu.bezelView.layer setCornerRadius:30];
}

- (void)example06
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setShowAnimation:JinnPopMenuAnimationNone];
    [popMenu setDismissAnimation:JinnPopMenuAnimationNone];
    [popMenu show];
}

- (void)example07
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setShowAnimation:JinnPopMenuAnimationFade];
    [popMenu setDismissAnimation:JinnPopMenuAnimationFade];
    [popMenu show];
}

- (void)example08
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setMaxItemNumEachLine:4];
    [popMenu show];
}

- (void)example09
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
    [popMenu setOffset:100];
    [popMenu show];
}

- (void)example10
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
                                                                   titleColor:COLOR_ITEM
                                                                         icon:[UIImage imageNamed:self.menuImages[i][0]]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.view popMenus:[items copy]];
    [popMenu show];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idendifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idendifier];
    }
    
    cell.textLabel.text = self.titles[indexPath.row][0];
    cell.detailTextLabel.text = self.titles[indexPath.row][1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.titles[indexPath.row][1] isEqualToString:@"example00"])
    {
        [self example00];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example01"])
    {
        [self example01];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example02"])
    {
        [self example02];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example03"])
    {
        [self example03];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example04"])
    {
        [self example04];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example05"])
    {
        [self example05];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example06"])
    {
        [self example06];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example07"])
    {
        [self example07];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example08"])
    {
        [self example08];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example09"])
    {
        [self example09];
    }
    else if ([self.titles[indexPath.row][1] isEqualToString:@"example10"])
    {
        [self example10];
    }
}

#pragma mark - JinnPopMenuDelegate

- (void)popMenu:(JinnPopMenu *)popMenu didSelectAtIndex:(NSInteger)index
{
    NSLog(@"Item (%d) did select!", (int)index);
}

- (void)popMenuBackgroundViewDidTap:(JinnPopMenu *)popMenu
{
    NSLog(@"Background view did tap!");
}

#pragma mark - Util

/**
 *  调整图片颜色
 *
 *  @param color
 *  @param image
 *
 *  @return
 */
- (UIImage *)imageWithColor:(UIColor *)color image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
