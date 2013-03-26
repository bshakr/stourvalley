//
//  SVAppDelegate.h
//  stourvalley
//
//  Created by Bassem on 11/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVMapViewController.h"
@class SVViewController;

@interface SVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SVMapViewController *viewController;

@end
