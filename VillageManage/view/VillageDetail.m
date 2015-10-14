//
//  VillageDetail.m
//  VillageManage
//
//  Created by Wenlong on 15-10-14.
//  Copyright (c) 2015年 hali. All rights reserved.
//

#import "VillageDetail.h"

@interface VillageDetail ()
@property (weak, nonatomic) IBOutlet UIImageView *btn1UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn1Select;
@property (weak, nonatomic) IBOutlet UIImageView *btn2UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn2Select;
@property (weak, nonatomic) IBOutlet UIImageView *btn3UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn3Select;
@property (weak, nonatomic) IBOutlet UIImageView *btn4UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn4Select;
@property (weak, nonatomic) IBOutlet UIImageView *btn5UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn5Select;
@property (weak, nonatomic) IBOutlet UIImageView *btn6UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn6Select;
@property (weak, nonatomic) IBOutlet UIWebView *fullWebView;

@end

@implementation VillageDetail

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
    [self OnSelectTab:1];
}

- (void)OnSelectTab:(int)tag
{
    [self.btn1Select setHidden:tag != 1];
    [self.btn1UnSelect setHidden:tag == 1];
    [self.btn2Select setHidden:tag != 2];
    [self.btn2UnSelect setHidden:tag == 2];
    [self.btn3Select setHidden:tag != 3];
    [self.btn3UnSelect setHidden:tag == 3];
    [self.btn4Select setHidden:tag != 4];
    [self.btn4UnSelect setHidden:tag == 4];
    [self.btn5Select setHidden:tag != 5];
    [self.btn5UnSelect setHidden:tag == 5];
    [self.btn6Select setHidden:tag != 6];
    [self.btn6UnSelect setHidden:tag == 6];
}

- (IBAction)OnClickBtn1:(id)sender {
    [self OnSelectTab:1];
}

- (IBAction)OnClickBtn2:(id)sender {
    [self OnSelectTab:2];
}

- (IBAction)OnClickBtn3:(id)sender {
    [self OnSelectTab:3];
}

- (IBAction)OnClickBtn4:(id)sender {
    [self OnSelectTab:4];
}

- (IBAction)OnClickBtn5:(id)sender {
    [self OnSelectTab:5];
}

- (IBAction)OnClickBtn6:(id)sender {
    [self OnSelectTab:6];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
