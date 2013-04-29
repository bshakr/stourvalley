//
//  SVAWebView.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 25/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVAWebView : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic) NSString *address;
@property (nonatomic) NSString *pagetitle;
@end
