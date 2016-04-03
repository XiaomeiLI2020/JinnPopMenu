//
//  ViewController.m
//  JinnPopViewExample
//
//  Created by jinnchang on 16/4/3.
//  Copyright © 2016年 Jinn Chang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#import "JinnPopView.h"

#define COLOR_ITEM [UIColor grayColor]
#define COLOR_ITEM_SELECTED [UIColor whiteColor]

@interface ViewController () <JinnPopViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *normalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [normalButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [normalButton setTitle:@"PopMenuIconLabel" forState:UIControlStateNormal];
    [normalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [normalButton addTarget:self action:@selector(normalButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [iconButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [iconButton setTitle:@"PopMenuIcon" forState:UIControlStateNormal];
    [iconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [iconButton addTarget:self action:@selector(iconButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *segmentedContolButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [segmentedContolButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [segmentedContolButton setTitle:@"PopSegmentedContol" forState:UIControlStateNormal];
    [segmentedContolButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [segmentedContolButton addTarget:self action:@selector(segmentedContolButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:normalButton];
    [self.view addSubview:iconButton];
    [self.view addSubview:segmentedContolButton];
    
    [normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(iconButton.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(segmentedContolButton.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    [segmentedContolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(50);
    }];
}

- (void)normalButtonClicked
{
    JinnPopMenu *popMenuItem1 =
    [[JinnPopMenu alloc] initWithTitle:@"删除"
                         selectedTitle:@"删除"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"delete"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"delete"]]];
    
    JinnPopMenu *popMenuItem2 =
    [[JinnPopMenu alloc] initWithTitle:@"下载"
                         selectedTitle:@"下载"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"download"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"download"]]];
    
    JinnPopMenu *popMenuItem3 =
    [[JinnPopMenu alloc] initWithTitle:@"编辑"
                         selectedTitle:@"编辑"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"edit"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"edit"]]];
    
    JinnPopMenu *popMenuItem4 =
    [[JinnPopMenu alloc] initWithTitle:@"信息"
                         selectedTitle:@"信息"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"message"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"message"]]];
    
    JinnPopMenu *popMenuItem5 =
    [[JinnPopMenu alloc] initWithTitle:@"搜索"
                         selectedTitle:@"搜索"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"search"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"search"]]];
    
    JinnPopMenu *popMenuItem6 =
    [[JinnPopMenu alloc] initWithTitle:@"分享"
                         selectedTitle:@"分享"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"share"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"share"]]];
    
    NSArray *popMenus = @[popMenuItem1, popMenuItem2, popMenuItem3, popMenuItem4, popMenuItem5, popMenuItem6];
    JinnPopView *popView = [[JinnPopView alloc] initWithPopMenus:popMenus];
    popView.shouldHideBackgroundTapped = YES;
    popView.backgroundView.backgroundColor = [UIColor blackColor];
    popView.delegate = self;
    [self.view addSubview:popView];
    [popView showAnimated:YES];
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}

- (void)iconButtonClicked
{
    JinnPopMenu *popMenuItem1 =
    [[JinnPopMenu alloc] initWithIcon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"delete"]]
                         selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"delete"]]];
    
    JinnPopMenu *popMenuItem2 =
    [[JinnPopMenu alloc] initWithIcon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"download"]]
                         selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"download"]]];
    
    JinnPopMenu *popMenuItem3 =
    [[JinnPopMenu alloc] initWithIcon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"edit"]]
                         selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"edit"]]];
    
    JinnPopMenu *popMenuItem4 =
    [[JinnPopMenu alloc] initWithIcon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"message"]]
                         selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"message"]]];
    
    JinnPopMenu *popMenuItem5 =
    [[JinnPopMenu alloc] initWithIcon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"search"]]
                         selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"search"]]];
    
    JinnPopMenu *popMenuItem6 =
    [[JinnPopMenu alloc] initWithIcon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"share"]]
                         selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"share"]]];
    
    NSArray *popMenus = @[popMenuItem1, popMenuItem2, popMenuItem3, popMenuItem4, popMenuItem5, popMenuItem6];
    JinnPopView *popView = [[JinnPopView alloc] initWithPopMenus:popMenus];
    popView.margin = CGPointMake(20, 20);
    popView.shouldHideBackgroundTapped = YES;
    popView.bezelView.backgroundColor = [UIColor blackColor];
    popView.bezelView.layer.cornerRadius = 20;
    popView.delegate = self;
    [self.view addSubview:popView];
    [popView showAnimated:YES];
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}

- (void)segmentedContolButtonClicked
{
    JinnPopMenu *popMenuItem1 =
    [[JinnPopMenu alloc] initWithTitle:@"删除"
                         selectedTitle:@"删除"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"delete"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"delete"]]];
    
    JinnPopMenu *popMenuItem2 =
    [[JinnPopMenu alloc] initWithTitle:@"下载"
                         selectedTitle:@"下载"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"download"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"download"]]];
    
    JinnPopMenu *popMenuItem3 =
    [[JinnPopMenu alloc] initWithTitle:@"编辑"
                         selectedTitle:@"编辑"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"edit"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"edit"]]];
    
    JinnPopMenu *popMenuItem4 =
    [[JinnPopMenu alloc] initWithTitle:@"信息"
                         selectedTitle:@"信息"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"message"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"message"]]];
    
    JinnPopMenu *popMenuItem5 =
    [[JinnPopMenu alloc] initWithTitle:@"搜索"
                         selectedTitle:@"搜索"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"search"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"search"]]];
    
    JinnPopMenu *popMenuItem6 =
    [[JinnPopMenu alloc] initWithTitle:@"分享"
                         selectedTitle:@"分享"
                            titleColor:COLOR_ITEM
                    selectedTitleColor:COLOR_ITEM_SELECTED
                                  icon:[self imageVithColor:COLOR_ITEM image:[UIImage imageNamed:@"share"]]
                          selectedIcon:[self imageVithColor:COLOR_ITEM_SELECTED image:[UIImage imageNamed:@"share"]]];
    
    NSArray *popMenus = @[popMenuItem1, popMenuItem2, popMenuItem3, popMenuItem4, popMenuItem5, popMenuItem6];
    JinnPopView *popView = [[JinnPopView alloc] initWithPopMenus:popMenus];
    popView.mode = JinnPopViewModeSegmentedControl;
    popView.shouldHideBackgroundTapped = YES;
    popView.backgroundView.backgroundColor = [UIColor blackColor];
    popView.delegate = self;
    [self.view addSubview:popView];
    [popView showAnimated:NO];
    [popView selectItemAtIndex:0];
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}

- (UIImage *)imageVithColor:(UIColor *)color image:(UIImage *)image
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

#pragma mark - JinnPopViewDelegate

- (void)itemSelectedAtIndex:(NSInteger)index
{
    NSLog(@"%d", (int)index);
}

@end
