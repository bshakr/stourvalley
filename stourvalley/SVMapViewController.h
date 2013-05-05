//
//  SVMapViewController.h
//  stourvalley
//
//  Created by Bassem on 12/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SVMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    IBOutlet MKMapView *worldView;

}

-(void) findLocation;
-(void) foundLocation:(CLLocation *)loc;


@end
