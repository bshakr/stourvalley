//
//  SVAppDelegate.h
//  stourvalley
//
//  Created by Bassem on 11/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVMapboxViewController.h"
@class SVViewController;


@interface SVAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSManagedObjectContext *eventContext;
    NSArray *allEvents;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SVMapboxViewController *viewController;

- (void)checkEventsData;

@end
