//
//  FAdjustFrame.h
//  ZMKeyboard
//
//  Created by zhoumeineng on 2018/5/3.
//  Copyright © 2018年 zhoumeineng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FAdjustFrame : NSObject
@property(nonatomic,assign)UIView *headView;
@property(nonatomic,assign)id allView;
-(void)AdjustHeadFrame:(NSNotification*)info;
-(void)EndEditing;
@end
