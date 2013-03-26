//
//  SVMapViewController.m
//  stourvalley
//
//  Created by Bassem on 12/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMapViewController.h"
#import "NVSlideMenuController.h"

@interface SVMapViewController ()

@end

@implementation SVMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [worldView setShowsUserLocation:YES];
    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage *)listImage {
    return [UIImage imageNamed:@"list.png"];
}

- (UIBarButtonItem *)slideOutBarButton {
    return [[UIBarButtonItem alloc] initWithImage:[self listImage]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(slideOut:)];
}

-(void) findLocation
{
    [locationManager startUpdatingLocation];
    
}
-(void)foundLocation:(CLLocation *)loc
{
}



#pragma mark - Event handlers

- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}


#pragma mark - CLLocationManagerDelegate
#pragma - CLLocationManager Delegate Methods

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", locations.lastObject);
    CLLocation *lastLocation = [locations lastObject];
    NSTimeInterval t = [[lastLocation timestamp] timeIntervalSinceNow];
    if(t < -180)
    {
        return;
    }
    [self foundLocation:lastLocation];
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    if([error code] != kCLErrorLocationUnknown)
    {
        NSLog(@"Could not find location: %@", error);
        [locationManager stopUpdatingLocation];
    }
}


#pragma - MKMapViewDelegate Delegate Methods

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D location = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 500, 500);
    [worldView setRegion:region animated:YES];
}


@end
