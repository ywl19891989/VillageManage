//
//  WebView.m
//  VillageManage
//
//  Created by Wenlong on 15-10-13.
//  Copyright (c) 2015年 hali. All rights reserved.
//

#import "WebView.h"

@interface WebView ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebView

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

- (void)LoadUrl:(NSString*)fileName
{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html" inDirectory:@""];
    
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSLog(@"url\n%@", url);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
