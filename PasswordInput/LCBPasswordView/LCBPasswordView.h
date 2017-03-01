//
//  LCBPasswordView.h
//  PasswordInput
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import <UIKit/UIKit.h>

//输入完成
typedef void(^FinishedInput)(NSString *);
//取消
typedef void(^CancelInput)(NSString *);

/**协议*/
@protocol LCBPasswordViewDelegate <NSObject>

@required
/**
 *  传递密码
 *
 *  @param pwdView  用来判断是哪一个视图
 *  @param password 密码
 */
- (void)passwordView:(UIView *)pwdView Password:(NSString *)password;

@end

@interface LCBPasswordView : UIView

@property (nonatomic , assign) id<LCBPasswordViewDelegate> delegate;


+ (instancetype)setWithFrame:(CGRect)frame InputCompleted:(FinishedInput)finished InputCancel:(CancelInput)cancel;


@end
