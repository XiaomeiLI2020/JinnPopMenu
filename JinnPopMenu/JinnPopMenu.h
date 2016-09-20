/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnPopMenu.h
 **  Description: 弹出式菜单, 依赖 Masonry 控件, 支持各种界面的适配(包括旋转), 支持各种自定义样式
 **
 **  Author:  jinnchang
 **  Date:    16/9/19
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import <UIKit/UIKit.h>

/**
 *  菜单方式
 */
typedef NS_ENUM(NSInteger, JinnPopMenuMode)
{
    /**
     *  普通菜单
     */
    JinnPopMenuModeNormal,
    
    /**
     *  选项菜单
     */
    JinnPopMenuModeSegmentedControl
};

/**
 *  风格样式
 */
typedef NS_ENUM(NSInteger, JinnPopMenuStyle)
{
    /**
     *  纯色
     */
    JinnPopMenuStyleSolidColor,
    
    /**
     *  毛玻璃
     */
    JinnPopMenuStyleBlur
};

/**
 *  动画
 */
typedef NS_ENUM(NSInteger, JinnPopMenuAnimation)
{
    /**
     *  无动画
     */
    JinnPopMenuAnimationNone,
    
    /**
     *  淡变动画
     */
    JinnPopMenuAnimationFade,
    
    /**
     *  缩放动画
     */
    JinnPopMenuAnimationZoom
};

#pragma mark - JinnPopMenuItem

/***************************************************************************************************
 **
 ** JinnPopMenuItem
 **
 **************************************************************************************************/

@interface JinnPopMenuItem : UIButton

/**
 *  纯文本菜单
 *
 *  @param title
 *  @param titleColor
 *
 *  @return
 */
- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor;

/**
 *  纯图标菜单
 *
 *  @param icon
 *
 *  @return
 */
- (instancetype)initWithIcon:(UIImage *)icon;

/**
 *  图标文本菜单
 *
 *  @param title
 *  @param titleColor
 *  @param icon
 *
 *  @return
 */
- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         icon:(UIImage *)icon;

/**
 *  纯文本选项菜单
 *
 *  @param title
 *  @param titleColor
 *  @param selectedTitle
 *  @param selectedTitleColor
 *
 *  @return
 */
- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                selectedTitle:(NSString *)selectedTitle
           selectedTitleColor:(UIColor *)selectedTitleColor;

/**
 *  纯图标选项菜单
 *
 *  @param icon
 *  @param selectedIcon
 *
 *  @return
 */
- (instancetype)initWithIcon:(UIImage *)icon
                selectedIcon:(UIImage *)selectedIcon;

/**
 *  图标文本选项菜单
 *
 *  @param title
 *  @param titleColor
 *  @param selectedTitle
 *  @param selectedTitleColor
 *  @param icon
 *  @param selectedIcon
 *
 *  @return
 */
- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                selectedTitle:(NSString *)selectedTitle
           selectedTitleColor:(UIColor *)selectedTitleColor
                         icon:(UIImage *)icon
                 selectedIcon:(UIImage *)selectedIcon;

/**
 *  图标视图
 */
@property (nonatomic, strong) UIImageView *iconView;

/**
 *  文本视图
 */
@property (nonatomic, strong) UILabel *itemLabel;

/**
 *  设置菜单选中状态
 *
 *  @param selected
 */
- (void)setItemSelected:(BOOL)selected;

@end

#pragma mark - JinnPopMenuDelegate

/***************************************************************************************************
 **
 ** JinnPopMenuDelegate
 **
 **************************************************************************************************/

@class JinnPopMenu;

@protocol JinnPopMenuDelegate <NSObject>

/**
 *  菜单选中触发事件代理
 *
 *  @param popMenu
 *  @param index
 */
- (void)popMenu:(JinnPopMenu *)popMenu didSelectAtIndex:(NSInteger)index;

@optional

/**
 *  背景点击触发事件代理(包括 backgroundView 和 bezelView)
 *
 *  @param popMenu
 */
- (void)popMenuBackgroundViewDidTap:(JinnPopMenu *)popMenu;

@end

#pragma mark - JinnPopMenu

/***************************************************************************************************
 **
 ** JinnPopMenu
 **
 **************************************************************************************************/

@interface JinnPopMenu : UIView

#pragma mark Property

@property (nonatomic, weak) id<JinnPopMenuDelegate> delegate;

/**
 *  菜单方式, 默认:JinnPopMenuModeNormal
 */
@property (nonatomic, assign) JinnPopMenuMode mode;

/**
 *  整体背景样式, 默认:JinnPopMenuStyleSolidColor([UIColor darkGrayColor])
 */
@property (nonatomic, assign) JinnPopMenuStyle backgroundStyle;

/**
 *  整体背景视图, 可在 show 之后重新自定义样式
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 *  局部边框样式, 默认:JinnPopMenuStyleSolidColor([UIColor clearColor])
 */
@property (nonatomic, assign) JinnPopMenuStyle bezelStyle;

/**
 *  局部边框视图, 可在 show 之后重新自定义样式
 */
@property (nonatomic, strong) UIView *bezelView;

/**
 *  局部边框视图 bezelView 与 backgroundView 的纵向偏移, 默认:0(即中心点对齐)
 */
@property (nonatomic, assign) CGFloat offset;

/**
 *  局部边框视图 bezelView 与选项菜单的边距, 默认:(0, 0)
 */
@property (nonatomic, assign) CGPoint margin;

/**
 *  每行最多菜单数, 默认:3
 */
@property (nonatomic, assign) NSInteger maxItemNumEachLine;

/**
 *  菜单大小, 默认:(50, 70)
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 *  菜单横向间距, 默认:30
 */
@property (nonatomic, assign) CGFloat itemSpaceHorizontal;

/**
 *  菜单纵向间距, 默认:30
 */
@property (nonatomic, assign) CGFloat itemSpaceVertical;

/**
 *  显示动画类型, 默认:JinnPopMenuAnimationZoom
 */
@property (nonatomic, assign) JinnPopMenuAnimation showAnimation;

/**
 *  显示动画时间, 默认:0.4f
 */
@property (nonatomic, assign) CGFloat showAnimationDuration;

/**
 *  隐藏动画类型, 默认:JinnPopMenuAnimationNone
 */
@property (nonatomic, assign) JinnPopMenuAnimation dismissAnimation;

/**
 *  隐藏动画时间, 默认:0.4f
 */
@property (nonatomic, assign) CGFloat dismissAnimationDuration;

/**
 *  点击背景区域是否自动隐藏视图, 默认:NO
 */
@property (nonatomic, assign) BOOL shouldHideWhenBackgroundTapped;

/**
 *  选中菜单时是否自动隐藏视图, 默认:YES
 */
@property (nonatomic, assign) BOOL shouldHideWhenItemSelected;

/**
 *  当前选中的菜单序号
 */
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

#pragma mark Method

- (instancetype)initWithDelegate:(id<JinnPopMenuDelegate>)delegate superView:(UIView *)superView popMenus:(NSArray *)popMenus;

/**
 *  弹出视图
 */
- (void)show;

/**
 *  隐藏视图
 */
- (void)dismiss;

/**
 *  选中相应序号的菜单
 */
- (void)selectItemAtIndex:(NSInteger)index;

@end