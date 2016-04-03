/***************************************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnPopView.m
 **
 ** Description: 弹出视图，可用于弹出菜单、分段选择，
 ** 依赖Masonry控件，支持各种界面的适配，包括旋转,支持各种样式自定义
 **
 ** History
 ** ------------------------------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-04-03
 ** Description: 创建文件
 ** Version: 1.0.0
 **************************************************************************************************/

#import "JinnPopView.h"
#import "Masonry.h"

#define TITLE_FONT_SIZE 12
#define ANIMATION_DURATION 0.4f

/***************************************************************************************************
 ** JinnPopMenu
 **************************************************************************************************/

@interface JinnPopMenu ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *selectedTitle;
@property (nonatomic, strong) UIColor  *titleColor;
@property (nonatomic, strong) UIColor  *selectedTitleColor;
@property (nonatomic, strong) UIImage  *icon;
@property (nonatomic, strong) UIImage  *selectedIcon;

@end

@implementation JinnPopMenu

- (instancetype)initWithIcon:(UIImage *)icon
{
    return [self initWithTitle:nil titleColor:nil icon:icon];
}

- (instancetype)initWithIcon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon
{
    return [self initWithTitle:nil selectedTitle:nil titleColor:nil selectedTitleColor:nil icon:icon selectedIcon:selectedIcon];
}

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor icon:(UIImage *)icon
{
    return [self initWithTitle:title selectedTitle:nil titleColor:titleColor selectedTitleColor:nil icon:icon selectedIcon:nil];
}

- (instancetype)initWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon
{
    {
        self = [super init];
        
        if (self)
        {
            [self setTitle:title];
            [self setSelectedTitle:selectedTitle];
            [self setTitleColor:titleColor];
            [self setSelectedTitleColor:selectedTitleColor];
            [self setIcon:icon];
            [self setSelectedIcon:selectedIcon];
            [self initGui];
        }
        
        return self;
    }
}

- (void)initGui
{
    self.iconView = [[UIImageView alloc] init];
    self.iconView.image = self.icon;
    
    [self addSubview:self.iconView];
    
    if (self.title == nil)
    {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.icon.size.width, self.icon.size.height));
        }];
    }
    else
    {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.icon.size.width, self.icon.size.height));
        }];
        
        self.itemLabel = [[UILabel alloc] init];
        self.itemLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        self.itemLabel.text = self.title;
        self.itemLabel.textColor = self.titleColor;
        self.itemLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.itemLabel];
        [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.mas_equalTo(20);
        }];
    }
}

#pragma mark - Public Methods

- (void)setItemSelected:(BOOL)selected
{
    if (selected)
    {
        [self.iconView setImage:self.selectedIcon];
        [self.itemLabel setText:self.selectedTitle];
        [self.itemLabel setTextColor:self.selectedTitleColor];
    }
    else
    {
        [self.iconView setImage:self.icon];
        [self.itemLabel setText:self.title];
        [self.itemLabel setTextColor:self.titleColor];
    }
}

@end

/***************************************************************************************************
 ** JinnPopView
 **************************************************************************************************/

@interface JinnPopView ()

@property (nonatomic, strong) NSArray *popMenus;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) NSInteger itemsCount;
@property (nonatomic, assign) NSInteger itemsLinesCount;

@end

@implementation JinnPopView

- (instancetype)initWithPopMenus:(NSArray *)popMenus
{
    self = [super init];
    
    if (self)
    {
        [self setPopMenus:popMenus];
        [self defaultSetting];
    }
    
    return self;
}

- (void)defaultSetting
{
    self.mode = JinnPopViewModeMenu;
    self.backgroundStyle = JinnPopViewBackgroundStyleSolidColor;
    self.showAnimationType = JinnPopAnimationZoom;
    self.dismissAnimationType = JinnPopAnimationFade;
    self.itemSize = CGSizeMake(60, 60);
    self.itemSpaceHorizontal = 30;
    self.itemSpaceVertical = 40;
    self.offset = 0;
    self.margin = CGPointMake(0, 0);
    self.maxItemNumEachLine = 3;
    self.shouldHideItemSelected = NO;
    self.shouldHideBackgroundTapped = NO;
    self.backgroundView = [[UIView alloc] init];
    self.bezelView = [[UIView alloc] init];
}

#pragma mark - Public Methods

- (void)showAnimated:(BOOL)animated
{
    [self setAnimated:animated];
    [self initData];
    [self loadBackgroundView];
    [self loadBezelView];
    [self loadItems];
    
    if (animated)
    {
        switch (self.showAnimationType)
        {
            case JinnPopAnimationFade:
            {
                [self showAnimatedFade];
            }
                break;
            case JinnPopAnimationZoom:
            {
                [self showAnimatedZoom];
            }
                break;
            default:
                break;
        }
    }
}

- (void)dismissAnimated:(BOOL)animated
{
    if (animated)
    {
        switch (self.dismissAnimationType)
        {
            case JinnPopAnimationFade:
            {
                [self dismissAnimatedFade];
            }
                break;
            case JinnPopAnimationZoom:
            {
                [self dismissAnimatedZoom];
            }
                break;
            default:
                break;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ANIMATION_DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
    else
    {
        [self removeFromSuperview];
    }
}

- (void)selectItemAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
    
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenu *popMenu = self.popMenus[i];
        
        if (i == index)
        {
            [popMenu setItemSelected:YES];
        }
        else
        {
            [popMenu setItemSelected:NO];
        }
    }
}

#pragma mark - Private Methods

- (void)initData
{
    self.itemsCount = self.popMenus.count;
    self.itemsLinesCount = self.itemsCount % self.maxItemNumEachLine == 0 ? (self.itemsCount / self.maxItemNumEachLine) : (self.itemsCount / self.maxItemNumEachLine + 1);
}

- (void)loadBackgroundView
{
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)]];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
}

- (void)loadBezelView
{
    CGFloat bezelViewWidth = 2 * self.margin.x + self.itemSize.width * self.maxItemNumEachLine + self.itemSpaceHorizontal * (self.maxItemNumEachLine - 1);
    CGFloat bezelViewHeight = 2 * self.margin.y + self.itemSize.height * self.itemsLinesCount + self.itemSpaceVertical * (self.itemsLinesCount - 1);
    
    [self.bezelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)]];
    [self addSubview:self.bezelView];
    [self.bezelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(self.offset);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(bezelViewWidth, bezelViewHeight));
    }];
}

- (void)loadItems
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        CGFloat xOffset;
        CGFloat yOffset;
        
        JinnPopMenu *popMenu = self.popMenus[i];
        [popMenu setTag:i];
        [popMenu addTarget:self action:@selector(popMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:popMenu];
        
        if (self.itemsLinesCount == 1)
        {
            xOffset = i * (self.itemSize.width + self.itemSpaceHorizontal) + self.itemSize.width / 2 -
            (self.itemSize.width * self.itemsCount + self.itemSpaceHorizontal * (self.itemsCount - 1)) / 2;
            yOffset = self.offset;
        }
        else
        {
            xOffset = (i % self.maxItemNumEachLine) * (self.itemSize.width + self.itemSpaceHorizontal) + self.itemSize.width / 2 -
            (self.itemSize.width * self.maxItemNumEachLine + self.itemSpaceHorizontal * (self.maxItemNumEachLine - 1)) / 2;
            yOffset = (i / self.maxItemNumEachLine) * (self.itemSize.height + self.itemSpaceVertical) + self.itemSize.height / 2 -
            (self.itemSize.height * self.itemsLinesCount + self.itemSpaceVertical * (self.itemsLinesCount - 1)) / 2 + self.offset;
        }
        
        [popMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(yOffset);
            make.centerX.equalTo(self).offset(xOffset);
            make.size.mas_equalTo(CGSizeMake(self.itemSize.width, self.itemSize.height));
        }];
    }
}

- (void)backgroundViewTapped
{
    if (self.shouldHideBackgroundTapped)
    {
        [self dismissAnimated:self.animated];
    }
}

- (void)popMenuClicked:(UIButton *)sender
{
    self.selectedIndex = sender.tag;
    
    if ([self.delegate respondsToSelector:@selector(itemSelectedAtIndex:)])
    {
        [self.delegate itemSelectedAtIndex:self.selectedIndex];
    }
    
    if (self.shouldHideItemSelected)
    {
        [self dismissAnimated:self.animated];
    }
    
    if (self.mode == JinnPopViewModeSegmentedControl)
    {
        for (int i = 0; i < self.itemsCount; i++)
        {
            JinnPopMenu *popMenu = self.popMenus[i];
            
            if (i == self.selectedIndex)
            {
                [popMenu setItemSelected:YES];
            }
            else
            {
                [popMenu setItemSelected:NO];
            }
        }
    }
}

#pragma mark - Animation

- (void)showAnimatedZoom
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenu *popMenu = self.popMenus[i];
        CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
        popMenu.transform = transform;
        popMenu.alpha = 0;
        transform = CGAffineTransformMakeScale(1, 1);
        
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:12 options:UIViewAnimationOptionLayoutSubviews animations:^{
            popMenu.transform = transform;
            popMenu.alpha = 1;
        } completion:nil];
    }
}

- (void)dismissAnimatedZoom
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenu *popMenu = self.popMenus[i];
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
        popMenu.transform = transform;
        popMenu.alpha = 0;
        transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            popMenu.transform = transform;
            popMenu.alpha = 1;
        }];
    }
}

- (void)showAnimatedFade
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenu *popMenu = self.popMenus[i];
        popMenu.alpha = 0;
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            popMenu.alpha = 1;
        }];
    }
}

- (void)dismissAnimatedFade
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenu *popMenu = self.popMenus[i];
        popMenu.alpha = 1;
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            popMenu.alpha = 0;
        }];
    }
}

@end