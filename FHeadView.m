//
//  FHeadView.m
//  ZMKeyboard
//
//  Created by zhoumeineng on 2018/5/3.
//  Copyright © 2018年 zhoumeineng. All rights reserved.
//

#import "FHeadView.h"
#import <objc/runtime.h>
#import "FAdjustFrame.h"
#import "FKeyBoardFine.h"
@interface FHeadView()
@property(nonatomic,strong)UIView * HeadFace;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UIButton * doneBtn;
@property(nonatomic,strong)FAdjustFrame *AdjustFrame;
@end
@implementation FHeadView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self HeadFace];
        [self titleLable];
        [self doneBtn];
        [self AdjustFrame];
       
    }
    return self;
}
-(void)ShowHeadView:(NSNotification*)info{
    [self.AdjustFrame AdjustHeadFrame:info];
}
- (UIView *)HeadFace{
    if (!_HeadFace) {
        _HeadFace = [[UIView alloc]initWithFrame:CGRectMake(0, FHEIGHT, FWIGHT, 40)];
        UIBlurEffect * VisualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView * EffectView = [[UIVisualEffectView alloc]initWithEffect:VisualEffect];
        EffectView.frame =CGRectMake(0, 0, FWIGHT, 40);
        [_HeadFace addSubview:EffectView];
    }
    return _HeadFace;
}
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(FWIGHT/2-60, 0, 120, 40)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self.HeadFace addSubview:_titleLable];
    }
    return _titleLable;
}
- (UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(FWIGHT-80, 0, 60, 40)];
        [_doneBtn setTitle:@"done" forState:(UIControlStateNormal)];
        [_doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(DoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.HeadFace addSubview:_doneBtn];
    }
    return _doneBtn;
}
-(void)setDelegate:(id)Delegate{
    _Delegate = Delegate;
    self.titleLable.text = [self.Delegate isKindOfClass:[UITextField class]]?({((UITextField*)Delegate).placeholder;}):({@"输入内容";});
    self.AdjustFrame.allView = Delegate;
}
-(void)DoneAction:(UIButton*)icon{
    [self.Delegate endEditing:YES];
}
- (FAdjustFrame *)AdjustFrame{
    if (!_AdjustFrame) {
        _AdjustFrame = [[FAdjustFrame alloc]init];
        _AdjustFrame.headView = self.HeadFace;
    }
    return _AdjustFrame;
}
- (void)HidHeadView{
     [self.AdjustFrame EndEditing];
}
@end
