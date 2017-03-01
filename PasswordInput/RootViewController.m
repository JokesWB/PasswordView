//
//  RootViewController.m
//  PasswordInput
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "RootViewController.h"
#import "LCBPasswordView.h"

//static NSString *oldPwd = nil;
//static NSString *newPwd = nil;

@interface RootViewController ()<LCBPasswordViewDelegate>
{
    LCBPasswordView *view;
    LCBPasswordView *view1;
    NSString *oldPwd;
    NSString *newPwd;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    1.代理方法实现
    view = [[LCBPasswordView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 50)];
    view.delegate = self;
    [self.view addSubview:view];
    
    view1 = [[LCBPasswordView alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 50)];
    view1.delegate = self;
    [self.view addSubview:view1];
    
//    2.block回调实现
    /*
   view = [LCBPasswordView setWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 50) InputCompleted:^(NSString *pwd) {
       
       oldPwd = pwd;
        
    } InputCancel:^(NSString *pwd) {
        
    }];
    [self.view addSubview:view];
    
    
    view1 = [LCBPasswordView setWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 50) InputCompleted:^(NSString *pwd) {
        
        newPwd = pwd;
        
    } InputCancel:^(NSString *pwd) {
        
    }];
    [self.view addSubview:view1];
    */
    
}

#pragma mark - LCBPasswordViewDelegate方法, 得到密码
- (void)passwordView:(UIView *)pwdView Password:(NSString *)password
{
    if (pwdView == view) {
        oldPwd = password;
        NSLog(@"password == %@", password);
    } else if (pwdView == view1) {
        newPwd = password;
    }
    
    NSLog(@"old == %@,,, new === %@", oldPwd, newPwd);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"old == %@,,, new === %@", oldPwd, newPwd);
    [self.view endEditing:YES];
}


@end
