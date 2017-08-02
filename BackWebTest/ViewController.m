//
//  ViewController.m
//  BackWebTest
//
//  Created by Felix on 2017/7/24.
//  Copyright © 2017年 Felix. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;
//@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) NSMutableArray *htmlArray;
@property (nonatomic, strong) NSMutableArray *baseURLArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL back;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, 375, 500)];
    //    [self.view addSubview:self.webview];
    self.webview.delegate = self;
    self.htmlArray = [NSMutableArray array];
    self.baseURLArray = [NSMutableArray array];
    [self.webview loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://sina.cn"]]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webview loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    });
    //    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey: @"WebKitCacheModelPreferenceKey"];
    //    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey: @"WebKitMediaPlaybackAllowsInline"];
    //
    //    id webView = [self.webview valueForKeyPath:@"_internal.browserView._webView"];
    //    id preferences = [webView valueForKey:@"preferences"];
    //    [preferences performSelector:@selector(_postCacheModelChangedNotification)];
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *lJs = @"document.documentElement.innerHTML";
    NSString *html = [self.webview stringByEvaluatingJavaScriptFromString:lJs];
    if (self.back) {
        return;
    }
    [self.htmlArray addObject:html];
    [self.baseURLArray addObject:self.webview.request.URL];
    self.index = self.baseURLArray.count - 1;
    //    NSLog(@"%d", self.index);
    
}
- (IBAction)reload:(id)sender {
    [self.webview reload];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webview loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    });
}

- (IBAction)back:(id)sender {
    NSLog(@"%d", self.webview.canGoBack);
    [self.webview goBack];
    //    if (self.index) {
    //        self.index --;
    //    }
    //    self.back = YES;
    //    NSLog(@"%d", self.index);
    //    [self.webview loadHTMLString:self.htmlArray[_index] baseURL:self.baseURLArray[_index]];
    //    NSLog(@"%@", self.webview.request.URL);
}

- (IBAction)forward:(id)sender {
    //    if(self.index < self.htmlArray.count - 1) {
    //       self.index ++;
    //    }
    //
    //    [self.webview loadHTMLString:self.htmlArray[_index] baseURL:self.baseURLArray[_index]];
    NSLog(@"%d", self.webview.canGoForward);
    [self.webview goForward];
}

@end
