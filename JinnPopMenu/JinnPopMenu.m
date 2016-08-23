/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnPopMenu.m
 **  Description: 弹出式菜单, 依赖 Masonry 控件, 支持各种界面的适配(包括旋转), 支持各种自定义样式
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **
 **  Author: jinnchang
 **  Date: 16/8/22
 **  Version: 1.1.0
 **  Remark: 调整更多可自定义样式
 **************************************************************************************************/

#import "JinnPopMenu.h"
#import "Masonry.h"

static const CGFloat kTitleFontSize = 12.f;

#pragma mark - JinnPopMenuItem

/***************************************************************************************************
 **
 ** JinnPopMenuItem
 **
 **************************************************************************************************/

@interface JinnPopMenuItem ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *selectedTitle;
@property (nonatomic, strong) UIColor  *titleColor;
@property (nonatomic, strong) UIColor  *selectedTitleColor;
@property (nonatomic, strong) UIImage  *icon;
@property (nonatomic, strong) UIImage  *selectedIcon;

@end

@implementation JinnPopMenuItem

#pragma mark Init

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
{
    return [self initWithTitle:title
                    titleColor:titleColor
                 selectedTitle:nil
            selectedTitleColor:nil
                          icon:nil
                  selectedIcon:nil];
}

- (instancetype)initWithIcon:(UIImage *)icon
{
    return [self initWithTitle:nil
                    titleColor:nil
                 selectedTitle:nil
            selectedTitleColor:nil
                          icon:icon
                  selectedIcon:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         icon:(UIImage *)icon
{
    return [self initWithTitle:title
                    titleColor:titleColor
                 selectedTitle:nil
            selectedTitleColor:nil
                          icon:icon
                  selectedIcon:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                selectedTitle:(NSString *)selectedTitle
           selectedTitleColor:(UIColor *)selectedTitleColor
{
    return [self initWithTitle:title
                    titleColor:titleColor
                 selectedTitle:selectedTitle
            selectedTitleColor:selectedTitleColor
                          icon:nil
                  selectedIcon:nil];
}

- (instancetype)initWithIcon:(UIImage *)icon
                selectedIcon:(UIImage *)selectedIcon
{
    return [self initWithTitle:nil
                    titleColor:nil
                 selectedTitle:nil
            selectedTitleColor:nil
                          icon:icon
                  selectedIcon:selectedIcon];
}

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                selectedTitle:(NSString *)selectedTitle
           selectedTitleColor:(UIColor *)selectedTitleColor
                         icon:(UIImage *)icon
                 selectedIcon:(UIImage *)selectedIcon
{
    self = [super init];
    
    if (self)
    {
        [self setTitle:title];
        [self setTitleColor:titleColor];
        [self setSelectedTitle:selectedTitle];
        [self setSelectedTitleColor:selectedTitleColor];
        [self setIcon:icon];
        [self setSelectedIcon:selectedIcon];
        [self createViews];
    }
    
    return self;
}

- (void)createViews
{
    if (self.title == nil) // 纯图标菜单
    {
        UIImageView *iconView = [[UIImageView alloc] initWithImage:self.icon];
        [iconView setClipsToBounds:YES];
        [self addSubview:iconView];
        [self setIconView:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.icon.size.width, self.icon.size.height));
        }];
    }
    else if (self.icon == nil) // 纯本文菜单
    {
        UILabel *itemLabel = [[UILabel alloc] init];
        itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
        itemLabel.text = self.title;
        itemLabel.textColor = self.titleColor;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.clipsToBounds = YES;
        [self addSubview:itemLabel];
        [self setItemLabel:itemLabel];
        [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(self);
            make.size.mas_equalTo(self);
        }];
    }
    else // 图标文本菜单
    {
        UIImageView *iconView = [[UIImageView alloc] initWithImage:self.icon];
        [iconView setClipsToBounds:YES];
        [self addSubview:iconView];
        [self setIconView:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.icon.size.width, self.icon.size.height));
        }];
        
        UILabel *itemLabel = [[UILabel alloc] init];
        itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
        itemLabel.text = self.title;
        itemLabel.textColor = self.titleColor;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.clipsToBounds = YES;
        [self addSubview:itemLabel];
        [self setItemLabel:itemLabel];
        [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.top.equalTo(iconView.mas_bottom);
        }];
    }
}

#pragma mark Public

/**
 *  设置菜单选中状态
 *
 *  @param selected
 */
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

#pragma mark - JinnPopMenu

/***************************************************************************************************
 **
 ** JinnPopMenu
 **
 **************************************************************************************************/

@interface JinnPopMenu ()

@property (nonatomic, strong) UIView    *superView;
@property (nonatomic, strong) NSArray   *popMenus; // 菜单集合
@property (nonatomic, assign) NSInteger itemsCount; // 菜单总数
@property (nonatomic, assign) NSInteger itemsLinesCount; // 菜单行数

@end

@implementation JinnPopMenu

#pragma mark Init

- (instancetype)initWithDelegate:(id<JinnPopMenuDelegate>)delegate superView:(UIView *)superView popMenus:(NSArray *)popMenus
{
    self = [super init];
    
    if (self)
    {
        [self setDelegate:delegate];
        [self setSuperView:superView];
        [self setPopMenus:popMenus];
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.mode                           = JinnPopMenuModeNormal;
    self.backgroundStyle                = JinnPopMenuStyleSolidColor;
    self.bezelStyle                     = JinnPopMenuStyleSolidColor;
    self.offset                         = 0;
    self.margin                         = CGPointMake(0, 0);
    self.maxItemNumEachLine             = 3;
    self.itemSize                       = CGSizeMake(50, 70);
    self.itemSpaceHorizontal            = 30;
    self.itemSpaceVertical              = 30;
    self.showAnimation                  = JinnPopMenuAnimationZoom;
    self.showAnimationDuration          = 0.4f;
    self.dismissAnimation               = JinnPopMenuAnimationNone;
    self.dismissAnimationDuration       = 0.4f;
    self.shouldHideWhenItemSelected     = YES;
    self.shouldHideWhenBackgroundTapped = NO;
    _selectedIndex                      = -1;
    
    self.backgroundView = [[UIView alloc] init];
    self.bezelView = [[UIView alloc] init];
    
    [self.superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superView);
    }];
}

#pragma mark Public

- (void)show
{
    self.itemsCount = self.popMenus.count;
    self.itemsLinesCount = self.itemsCount % self.maxItemNumEachLine == 0 ? (self.itemsCount / self.maxItemNumEachLine) : (self.itemsCount / self.maxItemNumEachLine + 1);
    
    [self createBackgroundView];
    [self createBezelView];
    [self createItems];
    
    switch (self.showAnimation)
    {
        case JinnPopMenuAnimationNone:
        {
            [self showAnimatedNone];
        }
            break;
        case JinnPopMenuAnimationFade:
        {
            [self showAnimatedFade];
        }
            break;
        case JinnPopMenuAnimationZoom:
        {
            [self showAnimatedZoom];
        }
            break;
        default:
            break;
    }
}

- (void)dismiss
{
    switch (self.dismissAnimation)
    {
        case JinnPopMenuAnimationNone:
        {
            [self dismissAnimatedNone];
        }
            break;
        case JinnPopMenuAnimationFade:
        {
            [self dismissAnimatedFade];
        }
            break;
        case JinnPopMenuAnimationZoom:
        {
            [self dismissAnimatedZoom];
        }
            break;
        default:
            break;
    }
}

- (void)selectItemAtIndex:(NSInteger)index
{
    _selectedIndex = index;
    
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenuItem *popMenu = self.popMenus[i];
        
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

#pragma mark Private

- (void)createBackgroundView
{
    switch (self.backgroundStyle)
    {
        case JinnPopMenuStyleSolidColor:
        {
            [self.backgroundView setBackgroundColor:[UIColor darkGrayColor]];
            [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)]];
            [self.backgroundView setClipsToBounds:YES];
            [self addSubview:self.backgroundView];
            [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
            break;
        case JinnPopMenuStyleBlur:
        {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            [effectview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)]];
            [effectview setClipsToBounds:YES];
            [self addSubview:effectview];
            [self setBackgroundView:effectview];
            [effectview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
            break;
        default:
            break;
    }
}

- (void)createBezelView
{
    CGFloat bezelViewWidth = 2 * self.margin.x + self.itemSize.width * self.maxItemNumEachLine + self.itemSpaceHorizontal * (self.maxItemNumEachLine - 1);
    CGFloat bezelViewHeight = 2 * self.margin.y + self.itemSize.height * self.itemsLinesCount + self.itemSpaceVertical * (self.itemsLinesCount - 1);
    
    switch (self.bezelStyle)
    {
        case JinnPopMenuStyleSolidColor:
        {
            [self.bezelView setBackgroundColor:[UIColor clearColor]];
            [self.bezelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)]];
            [self.bezelView setClipsToBounds:YES];
            [self addSubview:self.bezelView];
            [self.bezelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self).offset(self.offset);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(bezelViewWidth, bezelViewHeight));
            }];
        }
            break;
        case JinnPopMenuStyleBlur:
        {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            [effectview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)]];
            [effectview setClipsToBounds:YES];
            [self addSubview:effectview];
            [self setBezelView:effectview];
            [effectview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self).offset(self.offset);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(bezelViewWidth, bezelViewHeight));
            }];
        }
            break;
        default:
            break;
    }
}

- (void)createItems
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        CGFloat xOffset;
        CGFloat yOffset;
        
        JinnPopMenuItem *popMenu = self.popMenus[i];
        [popMenu setTag:i];
        [popMenu addTarget:self action:@selector(popMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:popMenu];
        
        if (self.itemsLinesCount == 1)
        {
            xOffset = i * (self.itemSize.width + self.itemSpaceHorizontal) + self.itemSize.width / 2 - (self.itemSize.width * self.itemsCount + self.itemSpaceHorizontal * (self.itemsCount - 1)) / 2;
            yOffset = self.offset;
        }
        else
        {
            xOffset = (i % self.maxItemNumEachLine) * (self.itemSize.width + self.itemSpaceHorizontal) + self.itemSize.width / 2 - (self.itemSize.width * self.maxItemNumEachLine + self.itemSpaceHorizontal * (self.maxItemNumEachLine - 1)) / 2;
            yOffset = (i / self.maxItemNumEachLine) * (self.itemSize.height + self.itemSpaceVertical) + self.itemSize.height / 2 - (self.itemSize.height * self.itemsLinesCount + self.itemSpaceVertical * (self.itemsLinesCount - 1)) / 2 + self.offset;
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
    if ([self.delegate respondsToSelector:@selector(popMenuBackgroundViewDidTap:)])
    {
        [self.delegate popMenuBackgroundViewDidTap:self];
    }
    
    if (self.shouldHideWhenBackgroundTapped)
    {
        [self dismiss];
    }
}

- (void)popMenuClicked:(UIButton *)sender
{
    _selectedIndex = sender.tag;
    
    if ([self.delegate respondsToSelector:@selector(popMenu:didSelectAtIndex:)])
    {
        [self.delegate popMenu:self didSelectAtIndex:_selectedIndex];
    }
    
    if (self.mode == JinnPopMenuModeSegmentedControl)
    {
        for (int i = 0; i < self.itemsCount; i++)
        {
            JinnPopMenuItem *popMenu = self.popMenus[i];
            
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
    
    if (self.shouldHideWhenItemSelected)
    {
        [self dismiss];
    }
}

#pragma mark Animation

- (void)showAnimatedNone
{
    // 没有动画
}

- (void)dismissAnimatedNone
{
    [self removeFromSuperview];
}

- (void)showAnimatedZoom
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenuItem *popMenu = self.popMenus[i];
        CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
        [popMenu setTransform:transform];
        [popMenu setAlpha:0];
        
        transform = CGAffineTransformMakeScale(1, 1);
        [UIView animateWithDuration:self.showAnimationDuration
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:12
                            options:UIViewAnimationOptionLayoutSubviews animations:^{
                                [popMenu setTransform:transform];
                                [popMenu setAlpha:1];
                            } completion:nil];
    }
}

- (void)dismissAnimatedZoom
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenuItem *popMenu = self.popMenus[i];
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
        [popMenu setTransform:transform];
        [popMenu setAlpha:1];
        
        transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:self.dismissAnimationDuration
                         animations:^{
                             [popMenu setTransform:transform];
                             [popMenu setAlpha:0];
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }
}

- (void)showAnimatedFade
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenuItem *popMenu = self.popMenus[i];
        [popMenu setAlpha:0];
        
        [UIView animateWithDuration:self.showAnimationDuration
                         animations:^{
                             [popMenu setAlpha:1];
                         } completion:nil];
    }
}

- (void)dismissAnimatedFade
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        JinnPopMenuItem *popMenu = self.popMenus[i];
        [popMenu setAlpha:1];
        
        [UIView animateWithDuration:self.dismissAnimationDuration
                         animations:^{
                             [popMenu setAlpha:0];
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }
}

@end