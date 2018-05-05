//
//  FAdjustFrame.m
//  git:https://gitee.com/PIGLANG/KeyBoard.git
//
//  Created by zhoumeineng on 2018/5/3.
//  Copyright © 2018年 zhoumeineng. All rights reserved.
//
#import "FAdjustFrame.h"
#import "FKeyBoardFine.h"
#import <objc/runtime.h>
@implementation FAdjustFrame
{
    UIWindow * keyBoardWindow;
    UIView * supView;
    CGRect  supframe;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

/*设置head的frame 和 调整 输入框的frame*/
- (void)AdjustHeadFrame:(NSNotification *)info{
    NSValue * value = [info.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardFrame = [value CGRectValue];
    self.headView.frame = CGRectMake(0, keyBoardFrame.origin.y-40, FWIGHT, 40);
    [self CurentWindow];
    [keyBoardWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    }];
    [keyBoardWindow addSubview:self.headView];
    [self AdjustInput];
}


- (void)AdjustInput{
    const char * scroll = "UIScrollView";
    const char * contr = "UIViewController";
    const char * window = "UIWindow";
    id resbon =  [self.allView SuperViewClass];
    /**scroll*/
    if ([resbon isKindOfClass:objc_getClass(contr)]|[resbon isMemberOfClass:objc_getClass(contr)]) {
        UIViewController * control = resbon;
        if (![supView isEqual:control.view]) {
            supframe =  control.view.frame;
            supView = control.view;
        }
        [self AdjustSupView];
    }else if ([resbon isKindOfClass:objc_getClass(scroll)]|[resbon isMemberOfClass:objc_getClass(scroll)]){
        UIScrollView * scr = resbon;
        CGRect inputframe =  [_allView convertRect:((UIView*)_allView).frame toView:scr];
        CGFloat KeyBoardHeadMinY = CGRectGetMinY(self.headView.frame);
        CGFloat keyBoardHeight = FHEIGHT - KeyBoardHeadMinY;
        CGFloat spacing =  CGRectGetMaxY(inputframe)-scr.frame.size.height+keyBoardHeight;
        if (spacing>0) {
           [scr setContentOffset:CGPointMake(0, spacing) animated:YES];
        }
       
    }else if ([resbon isKindOfClass:objc_getClass(window)]|[resbon isMemberOfClass:objc_getClass(window)]){
        UIWindow * window = resbon;
        if (![supView isEqual:window]) {
            supframe =  window.frame;
            supView = window;
        }
        [self AdjustSupView];
    }
}
-(void)AdjustSupView{
    if ([((UIView*)_allView).superview isEqual:supView]){
        CGRect inputframe = ((UIView*)_allView).frame;
        inputframe = ((UIView*)_allView).frame;
        /**键盘head对应keyBoardWindow的fram*/
        CGFloat KeyBoardHeadMinY = CGRectGetMinY(self.headView.frame);
        /**视图MaxY*/
        CGFloat MaxY = CGRectGetMaxY(inputframe);
        if (KeyBoardHeadMinY<MaxY) {
            [UIView animateWithDuration:0.2 animations:^{
                supView.frame = CGRectMake(0,KeyBoardHeadMinY-MaxY, supframe.size.width, supframe.size.height);
            }];
        }
    }else{
        CGRect inputframe;
        CGFloat InpuMayY = ((UIView*)_allView).frame.size.height;
        UIView * supview = ((UIView*)_allView);
        while (1) {
            inputframe = supview.frame;
            InpuMayY+=CGRectGetMinY(inputframe);
            supview = supview.superview;
            if ( [supview isEqual:supView]) {
                break;
            }
        }
        
        CGFloat KeyBoardHeadMinY = CGRectGetMinY(self.headView.frame);
        /**视图MaxY*/
        if (KeyBoardHeadMinY<InpuMayY) {
            [UIView animateWithDuration:0.2 animations:^{
                supView.frame = CGRectMake(0,KeyBoardHeadMinY-InpuMayY, supframe.size.width, supframe.size.height);
            }];
        }
    }
}

- (void)EndEditing{
    [self.headView removeFromSuperview];
    [UIView animateWithDuration:0.6 animations:^{
        supView.frame = supframe;
    }];
}


-(void)CurentWindow{
    Class keywindowClass = NSClassFromString(@"UITextEffectsWindow");//UIRemoteKeyboardWindow
    NSArray<UIWindow*>* windows = [UIApplication sharedApplication].windows;
    [windows enumerateObjectsUsingBlock:^(UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.class isEqual:keywindowClass]) {
            keyBoardWindow = obj;
        }
    }];
}
@end
