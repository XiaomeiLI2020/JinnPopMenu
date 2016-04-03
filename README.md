# JinnLock
A PopView for iOS by jinnchang.
# Preview
![image](https://github.com/jinnchang/JinnPopView/blob/master/JinnPopViewExample/Preview/preview.gif)
# Usage
```objective-c
#import "JinnPopView.h"
```
* JinnPopMenu
```objc
- (instancetype)initWithIcon:(UIImage *)icon;
- (instancetype)initWithIcon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon;
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor icon:(UIImage *)icon;
- (instancetype)initWithTitle:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                   titleColor:(UIColor *)titleColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                         icon:(UIImage *)icon
                 selectedIcon:(UIImage *)selectedIcon;                 
```
* JinnPopView
```objc
NSArray *popMenus = @[popMenuItem1, popMenuItem2, popMenuItem3];
JinnPopView *popView = [[JinnPopView alloc] initWithPopMenus:popMenus];
popView.delegate = self;
[self.view addSubview:popView];
[popView showAnimated:YES];
```
* JinnPopViewDelegate
```objc
- (void)itemSelectedAtIndex:(NSInteger)index;
```
# Blog
http://blog.csdn.net/jinnchang