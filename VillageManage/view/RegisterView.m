//
//  RegisterView.m
//  VillageManage
//
//  Created by Wenlong on 15-10-11.
//  Copyright (c) 2015年 hali. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView ()

@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *pwdInput;
@property (weak, nonatomic) IBOutlet UITextField *accountInput;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumInput;
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextField *companyInput;
@end

@implementation RegisterView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)OnClickRegister:(id)sender
{
    NSString* account = [self.accountInput text];
    NSString* pwd = [self.pwdInput text];
    NSString* name = [self.nameInput text];
    NSString* company = [self.companyInput text];
    NSString* phoneNum = [self.phoneNumInput text];
    NSString* email = [self.emailInput text];
    
    if ([account length] == 0) {
        [AppDelegate ShowTips:@"请输入用户名!"];
    } else if ([pwd length] == 0) {
        [AppDelegate ShowTips:@"请输入密码!"];
    } else if ([name length] == 0) {
        [AppDelegate ShowTips:@"请输入姓名!"];
    } else if ([company length] == 0) {
        [AppDelegate ShowTips:@"请输入公司!"];
    } else if ([email length] == 0) {
        [AppDelegate ShowTips:@"请输入邮箱!"];
    } else if ([phoneNum length] == 0) {
        [AppDelegate ShowTips:@"请输入手机号码"];
    } else {
        NSDictionary* params = @{
                                 @"login" : account,
                                 @"pwd" : [NetWorkManager md5:pwd],
                                 @"name" : name,
                                 @"company" : company,
                                 @"mobile" : phoneNum,
                                 @"email" : email,
                                 };
        [NetWorkManager Register:params WithSuccess:^(AFHTTPRequestOperation *operation, id data) {
            if (data) {
                [AppDelegate jumpToLogin];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}

- (IBAction)OnClickBack:(id)sender
{
    [AppDelegate jumpToLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
