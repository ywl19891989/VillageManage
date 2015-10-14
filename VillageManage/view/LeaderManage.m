//
//  LeaderManage.m
//  VillageManage
//
//  Created by Wenlong on 15-10-14.
//  Copyright (c) 2015年 hali. All rights reserved.
//

#import "LeaderManage.h"

@interface LeaderManage ()
@property (weak, nonatomic) IBOutlet UIImageView *btn1UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn1Select;
@property (weak, nonatomic) IBOutlet UIImageView *btn2UnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *btn2Select;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LeaderManage

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
    
    [self OnClickBtn1:nil];
}

- (void)SetSelectBtn1:(BOOL)val
{
    [self.btn1Select setHidden:!val];
    [self.btn1UnSelect setHidden:val];
    [self.btn2Select setHidden:val];
    [self.btn2UnSelect setHidden:!val];
}

- (IBAction)OnClickBtn1:(id)sender
{
    [self SetSelectBtn1:YES];
    
    NSURL* url = [NSURL URLWithString:@"http://bohan.healbest.com/app/app_player_list.aspx?userid=9"];
    NSLog(@"url\n%@", url);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (IBAction)OnClickBtn2:(id)sender
{
    [self SetSelectBtn1:NO];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"(APP)村落列表" ofType:@"html" inDirectory:@""];
    
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSLog(@"url\n%@", url);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (IBAction)OnClickBtn3:(id)sender
{
    [AppDelegate jumpToVillageSelect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
