//
//  LoginView.m
//  VillageManage
//
//  Created by Wenlong on 15-10-11.
//  Copyright (c) 2015年 hali. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()
{
    BOOL isShowPwd;
}
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *pwdInput;
@property (weak, nonatomic) IBOutlet UIImageView *hidePwdIcon;
@property (weak, nonatomic) IBOutlet UIImageView *showPwdIcon;

@end

@implementation LoginView

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
    
    isShowPwd = NO;
    [self updatePwdShowHide];
}

- (void)updatePwdShowHide
{
    [self.showPwdIcon setHidden:!isShowPwd];
    [self.hidePwdIcon setHidden:isShowPwd];
    [self.pwdInput setSecureTextEntry:!isShowPwd];
}

- (IBAction)OnClickSwitchShowPwd:(id)sender
{
    isShowPwd = !isShowPwd;
    [self updatePwdShowHide];
}

- (IBAction)OnClickForgtPwd:(id)sender
{
    
}

- (IBAction)OnClickLogin:(id)sender
{
    NSString* mobile = [self.nameInput text];
    NSString* pwd = [self.pwdInput text];
    if ([mobile length] == 0) {
        [AppDelegate ShowTips:@"请输入用户名!"];
    } else if ([pwd length] == 0) {
        [AppDelegate ShowTips:@"请输入密码!"];
    } else {
        NSDictionary* params = @{
                                 @"mobile": mobile,
                                 @"pwd": [NetWorkManager md5:pwd]
                                 };
        [NetWorkManager Login:params WithSuccess:^(AFHTTPRequestOperation *operation, id data) {
            if (data) {
                NSLog(@"data %@", data);
                
                NSDictionary* userData = data[@"records"][0];
                
                int roleType = [userData[@"RoleType"] integerValue];
                
                if ( roleType == 1) {
                    [AppDelegate jumpToLeaderManage];
                } else if(roleType == 2) {
                    [AppDelegate jumpToVillageSelect];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}

- (IBAction)OnClickRegister:(id)sender
{
    [AppDelegate jumpToRegister];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
