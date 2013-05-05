//
//  SVAWebView.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 25/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SVAWebView : UIViewController
{
    //UIActivityIndicatorView *activityView;
    //UIView *loadingView;
    //UILabel *loadingLabel;

}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;

@property (nonatomic) NSString *address;
@property (nonatomic) NSString *pagetitle;


@end
