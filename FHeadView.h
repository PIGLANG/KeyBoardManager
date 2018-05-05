//
//  FHeadView.h
//  ZMKeyboard
//
//  Created by zhoumeineng on 2018/5/3.
//  Copyright © 2018年 zhoumeineng. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FHeadView : NSObject
// 显示head
-(void)ShowHeadView:(NSNotification*)info;
@property(nonatomic,assign)id Delegate;
-(void)HidHeadView;
@end
