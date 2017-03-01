//
//  LCBPasswordView.m
//  PasswordInput
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "LCBPasswordView.h"

#define kPasswordCount 6

@interface LCBPasswordView ()<UITextFieldDelegate>
{
    UIImageView *imageView;
    UITextField *_textfield;
    NSMutableArray *_imageArray;      //装图片视图
    NSMutableArray *_passwordArray;  //装密码
    NSInteger _count;
    CGFloat _pwdViewW;     //密码图片的宽度
    CGFloat _pwdViewH;     //密码图片的高度
    CGFloat _pwdViewY;     //密码图片的Y坐标
    CGFloat _pwdViewX;     //密码图片的X坐标
}
@property (nonatomic , copy) FinishedInput finishedInput;
@property (nonatomic , copy) CancelInput cancelInput;

@end

@implementation LCBPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpMyViews];
    }
    return self;
}



+ (instancetype)setWithFrame:(CGRect)frame InputCompleted:(FinishedInput)finished InputCancel:(CancelInput)cancel
{
    LCBPasswordView *pwdView = [[LCBPasswordView alloc] initWithFrame:frame];
    pwdView.finishedInput = finished;
    pwdView.cancelInput = cancel;
    return pwdView;
}



//添加视图
- (void)setUpMyViews
{
    _imageArray = [NSMutableArray array];
    _passwordArray = [NSMutableArray array];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_in"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardAppear)];
    [imageView addGestureRecognizer:tap];
    
    _textfield = [[UITextField alloc] init];
    _textfield.delegate = self;
    _textfield.keyboardType = UIKeyboardTypeNumberPad;
    _textfield.textColor = [UIColor clearColor];
    _textfield.tintColor = [UIColor clearColor];  //光标颜色
    [_textfield becomeFirstResponder];
    [self addSubview:_textfield];
    
}


- (void)layoutSubviews
{
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _textfield.frame = CGRectMake(0, 0, 1, imageView.frame.size.height);
    _pwdViewW = self.frame.size.width / kPasswordCount;
    _pwdViewH = imageView.frame.size.height;
    _pwdViewY = 0;
}

#pragma mark - UITextFieldDelegaet方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //如果不是删除
    if (![string isEqualToString:@""]) {
        if (_count < kPasswordCount) {
            //创建密码图片
            UIImageView *pwdView = [self ImageViewWithCount:_count];
            //添加图片视图
            [imageView addSubview:pwdView];
            //图片视图加入数组
            [_imageArray addObject:pwdView];
            //密码加入数组
            [_passwordArray addObject:string];
        }
        _count++;
    } else {
        if (_count > 0) {
            if (_count > kPasswordCount) {
                _count = kPasswordCount;
            }
            UIImageView *pwdView = _imageArray[_count - 1];  //取出这个密码图片
            //移除
            [pwdView removeFromSuperview];
            //从数组中删除图片
            [_imageArray removeObject:pwdView];
            //从数组中删除密码
            [_passwordArray removeLastObject];
            _count--;
        }
    }
    
    NSString *pwdStr = @"";
    if (_count == kPasswordCount) {
        for (int i = 0; i < _passwordArray.count; i++) {
            pwdStr =  [pwdStr stringByAppendingString:_passwordArray[i]];
        }
        if ([self.delegate respondsToSelector:@selector(passwordView:Password:)]) {
            [self.delegate passwordView:self Password:pwdStr];
        }
        
        if (self.finishedInput) {
            
            self.finishedInput(pwdStr);
        }
        
    }
    
    //如果超出长度，不能编辑
    if (_count > kPasswordCount) {
        return NO;
    }
    
    return YES;
}

//添加密码图片
- (UIImageView *)ImageViewWithCount:(NSInteger)count
{
    UIImageView *pwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(count * _pwdViewW, _pwdViewY, _pwdViewW, _pwdViewH)];
    pwdImageView.image = [UIImage imageNamed:@"yuan"];
    pwdImageView.contentMode = UIViewContentModeCenter;
    return pwdImageView;
}

//弹出键盘
- (void)keyboardAppear
{
    [_textfield becomeFirstResponder];
}




@end
