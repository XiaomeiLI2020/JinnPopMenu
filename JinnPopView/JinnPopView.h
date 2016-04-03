/***************************************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnPopView.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  控件样式
 */
typedef NS_ENUM(NSInteger, JinnPopViewMode)
{
    JinnPopViewModeMenu,
    JinnPopViewModeSegmentedControl
};

/**
 *  背景风格
 */
typedef NS_ENUM(NSInteger, JinnPopViewBackgroundStyle)
{
    JinnPopViewBackgroundStyleSolidColor,
    JinnPopViewBackgroundStyleBlur // 暂不支持
};

/**
 *  动画
 */
typedef NS_ENUM(NSInteger, JinnPopAnimation)
{
    JinnPopAnimationFade,
    JinnPopAnimationZoom
};

/***************************************************************************************************
 ** JinnPopMenu
 **************************************************************************************************/

@interface JinnPopMenu : UIButton

- (instancetype)initWithIcon:(UIImage *)icon;
- (instancetype)initWithIcon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon;
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor icon:(UIImage *)icon;
- (instancetype)initWithTitle:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                   titleColor:(UIColor *)titleColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                         icon:(UIImage *)icon
                 selectedIcon:(UIImage *)selectedIcon;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *itemLabel;

- (void)setItemSelected:(BOOL)selected;

@end

/***************************************************************************************************
 ** JinnPopViewDelegate
 **************************************************************************************************/

@protocol JinnPopViewDelegate <NSObject>

- (void)itemSelectedAtIndex:(NSInteger)index;

@end

/***************************************************************************************************
 ** JinnPopView
 **************************************************************************************************/

@interface JinnPopView : UIView

@property (nonatomic, weak) id<JinnPopViewDelegate> delegate;

/**
 *  控件样式，默认JinnPopViewModeMenu
 */
@property (nonatomic, assign) JinnPopViewMode mode;

/**
 *  背景样式，默认JinnPopViewBackgroundStyleSolidColor
 */
@property (nonatomic, assign) JinnPopViewBackgroundStyle backgroundStyle;

/**
 *  显示动画类型，默认:JinnPopAnimationZoom
 */
@property (nonatomic, assign) JinnPopAnimation showAnimationType;

/**
 *  隐藏动画类型，默认:JinnPopAnimationFade
 */
@property (nonatomic, assign) JinnPopAnimation dismissAnimationType;

/**
 *  菜单大小，默认:(60,60)
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 *  菜单横向间距，默认:30
 */
@property (nonatomic, assign) CGFloat itemSpaceHorizontal;

/**
 *  菜单纵向间距，默认:40
 */
@property (nonatomic, assign) CGFloat itemSpaceVertical;

/**
 *  边框视图bezelView与背景视图backgroundView的纵向偏移，默认:0
 */
@property (nonatomic, assign) CGFloat offset;

/**
 *  边框视图bezelView与菜单的边距，默认:(0,0)
 */
@property (nonatomic, assign) CGPoint margin;

/**
 *  每行最多菜单数，默认:3
 */
@property (nonatomic, assign) NSInteger maxItemNumEachLine;

/**
 *  点击背景区域是否自动隐藏视图，默认:NO
 */
@property (nonatomic, assign) BOOL shouldHideBackgroundTapped;

/**
 *  菜单选择时是否自动隐藏视图，默认:NO
 */
@property (nonatomic, assign) BOOL shouldHideItemSelected;

/**
 *  边框视图
 */
@property (nonatomic, strong) UIView *bezelView;

/**
 *  背景视图
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 *  当前选中的菜单序号
 */
@property (nonatomic, assign) NSInteger selectedIndex;

#pragma mark - JinnPopMenu Methods

- (instancetype)initWithPopMenus:(NSArray *)popMenus;

/**
 *  弹出视图
 */
- (void)showAnimated:(BOOL)animated;

/**
 *  隐藏视图
 */
- (void)dismissAnimated:(BOOL)animated;

/**
 *  选中相应序号的菜单
 */
- (void)selectItemAtIndex:(NSInteger)index;

@end