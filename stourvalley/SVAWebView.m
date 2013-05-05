//
//  SVAWebView.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 25/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "SVAWebView.h"

@interface SVAWebView ()
{
    NSTimer *timer;
}
- (void) webLoading;
@end



@implementation SVAWebView

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
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:187/255.0 green:83/255.0 blue:88/255.0 alpha:0.5]];
    
    // Do any additional setup after loading the view from its nib.
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    self.loadingView.center = self.webView.center;
    self.loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.loadingView.clipsToBounds = YES;
    self.loadingView.layer.cornerRadius = 10.0;
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.frame = CGRectMake(40, 20, self.activityView.bounds.size.width, self.activityView.bounds.size.height);
    [self.loadingView addSubview:self.activityView];
    
    self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 80, 20)];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.textColor = [UIColor whiteColor];
    self.loadingLabel.adjustsFontSizeToFitWidth = YES;
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.text = @"Loading...";
    [self.loadingView addSubview:self.loadingLabel];
    [self.activityView startAnimating];
    [self.view addSubview:self.loadingView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(webLoading) userInfo:nil repeats:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = NSLocalizedString(self.pagetitle, @"SVA");

    NSURL *url = [NSURL URLWithString:self.address];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void) webLoading
{
    if(!self.webView.loading)
    {   [self.activityView stopAnimating];
        [self.loadingView removeFromSuperview];
    }
	else
		[self.activityView startAnimating];

}


- (void) viewDidDisappear:(BOOL)animated
{
    NSURL *url = [NSURL URLWithString:self.address];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	 [self.activityView stopAnimating];
     [self.loadingView removeFromSuperview];
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><br /><br /><font size=+5 color='red'>Error<br /><br />Your request %@</font></center></html>",
							 error.localizedDescription];
	[self.webView loadHTMLString:errorString baseURL:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
