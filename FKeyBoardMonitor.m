//
//  FKeyBoardMonitor.m
// git:https://gitee.com/PIGLANG/KeyBoard.git
//
//  Created by zhoumeineng on 2018/5/3.
//  Copyright © 2018年 zhoumeineng. All rights reserved.
//

#import "FKeyBoardMonitor.h"
#import <UIKit/UIKit.h>
#import "FHeadView.h"
@interface FKeyBoardMonitor()
@property(nonatomic,strong)FHeadView * headView;
@end
@implementation FKeyBoardMonitor
{
    BOOL KeyboardShow;
    NSNotification * Inforc;
}
static FKeyBoardMonitor * KeyBoardMonitor = nil;
+(FKeyBoardMonitor*)KeyBoardManager{
    if (!KeyBoardMonitor) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            KeyBoardMonitor = [[FKeyBoardMonitor alloc]init];
        });
    }
    return KeyBoardMonitor;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self AddKeyBoardMonitor];
        [self headView];
        KeyboardShow = NO;
    }
    return self;
}
-(void)AddKeyBoardMonitor{
    [self addNotification:@selector(textFieldChange:) name:UITextFieldTextDidBeginEditingNotification];
    [self addNotification:@selector(textviewdChange:) name:UITextViewTextDidBeginEditingNotification];
    [self addNotification:@selector(textFieldDidEndEditing:) name:UITextViewTextDidBeginEditingNotification];
    [self addNotification:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification];
    [self addNotification:@selector(KeyboardDidShow:)
        name:UIKeyboardDidShowNotification];
    [self addNotification:@selector(KeyboardWillHide:)
        name:UIKeyboardWillHideNotification];
}
-(void)addNotification:(SEL)Metor name:(NSNotificationName)name{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:Metor name:name object:nil];
}
//监听事件
-(void)textFieldChange:(NSNotification*)info{
    self.headView.Delegate = info.object;
    [self KeyBoardAdjust];
}
-(void)textviewdChange:(NSNotification*)info{
    self.headView.Delegate = info.object;
    [self KeyBoardAdjust];
}
-(void)textFieldDidEndEditing:(NSNotification*)info{
}
-(void)textViewDidEndEditing:(NSNotification*)info{
}
-(void)KeyboardDidShow:(NSNotification*)info{
    Inforc = info;
    [self.headView ShowHeadView:info];
    KeyboardShow = YES;
}
-(void)KeyboardWillHide:(NSNotification*)info{
    KeyboardShow = NO;
    [self.headView HidHeadView];
}

-(void)KeyBoardAdjust{
    if (KeyboardShow&&Inforc) {
        [self.headView ShowHeadView:Inforc];
    }
}
- (FHeadView *)headView{
    if (!_headView) {
        _headView = [[FHeadView alloc]init];
    }
    return _headView;
}
@end
