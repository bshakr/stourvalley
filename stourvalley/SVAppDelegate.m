//
//  SVAppDelegate.m
//  stourvalley
//
//  Created by Bassem on 11/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVAppDelegate.h"

#import "SVMapboxViewController.h"
#import "SVMenuViewController.h"
#import "NVSlideMenuController.h"
#import "EventDataModel.h"



@implementation SVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.viewController = [[SVMapboxViewController alloc] init];

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];

    SVMenuViewController *menuController = [[SVMenuViewController alloc]init];
    NVSlideMenuController *slideController = [[NVSlideMenuController alloc] initWithMenuViewController:menuController andContentViewController:navController];
    self.window.rootViewController = slideController;
    [self.window makeKeyAndVisible];
    
    [self checkEventsData];
    
    return YES;
}


- (void)checkEventsData
{
    eventContext = [[EventDataModel sharedDataModel] mainContext];
    allEvents = nil;
    
    if(eventContext){
        NSLog(@" Appdeligate Context is ready to use");
        //[[EventDataModel sharedDataModel] clearAllEvents];
        allEvents = [[EventDataModel sharedDataModel] getAllEvents];
        
        if (allEvents.count == 0) {
            NSLog(@"Events entity is empty");
            [[EventDataModel sharedDataModel] creatEvents];
            allEvents = [[EventDataModel sharedDataModel] getAllEvents];
            NSLog(@" %d events created", allEvents.count);
            
        }else{
            NSInteger currentEvNum = [[EventDataModel sharedDataModel] arrayForObject].count;
            if (allEvents.count != currentEvNum) {
                 NSLog(@"Event.entity diff, current events %d, Stored events %d ",currentEvNum, allEvents.count);
                [[EventDataModel sharedDataModel] clearAllEvents];
                [[EventDataModel sharedDataModel] creatEvents];
                 allEvents = [[EventDataModel sharedDataModel] getAllEvents];
                 NSLog(@"Updated %d events CoreData", allEvents.count);
            }

        }
        
    }else{
        NSLog(@"eventContext == nil, Event.entity not found");
    }

}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
