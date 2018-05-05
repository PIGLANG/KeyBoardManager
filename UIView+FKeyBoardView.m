//
//  UIView+FKeyBoardView.m
//  ZMKeyboard
//
//  Created by zhoumeineng on 2018/5/4.
//  Copyright © 2018年 zhoumeineng. All rights reserved.
//
#import "UIView+FKeyBoardView.h"
#import <objc/runtime.h>
@implementation UIView (FKeyBoardView)
-(id)SuperViewClass{
    const char * scrollclass = "UIScrollView";
    const char * contr = "UIViewController";
    const char * window = "UIWindow";
    UIResponder *next = [self nextResponder];
    Class scr = objc_getClass(scrollclass);
    Class ctr = objc_getClass(contr);
    Class win = objc_getClass(window);
    while (1) {
        if ([next isMemberOfClass:scr]|[next isKindOfClass:scr]|[next isMemberOfClass:ctr]|[next isKindOfClass:ctr]|[next isMemberOfClass:win]|[next isKindOfClass:win]) {
            break;
        }
      next = next.nextResponder;
    }
    return next;
}
@end
