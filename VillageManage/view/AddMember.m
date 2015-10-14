//
//  AddMember.m
//  VillageManage
//
//  Created by Wenlong on 15-10-11.
//  Copyright (c) 2015年 hali. All rights reserved.
//

#import "AddMember.h"

@interface AddMember ()

@property (weak, nonatomic) IBOutlet UITextField *accountInput;
@property (weak, nonatomic) IBOutlet UITextField *pwdInput;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextView *markInput;
@property (weak, nonatomic) IBOutlet UIButton *selectVillageBtn;
@end

@implementation AddMember

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

- (IBAction)OnClickSelectVillage:(id)sender
{
    
}

- (IBAction)OnClickAdd:(id)sender
{
    
}

- (IBAction)OnClickCancel:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
