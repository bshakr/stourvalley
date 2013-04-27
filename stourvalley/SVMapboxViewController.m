//
//  SVMapboxViewController.m
//  stourvalley
//
//  Created by Bassem on 19/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMapboxViewController.h"
#import "Mapbox.h"
@interface SVMapboxViewController ()

@end

@implementation SVMapboxViewController

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
	// Do any additional setup after loading the view.
    RMMapBoxSource *tileSource = [[RMMapBoxSource alloc] initWithMapID:@"bshaker.map-xahr0dzz"];
    CLLocationCoordinate2D initialLocation = CLLocationCoordinate2DMake(51.215499999999984, 0.8911000000000154);
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource centerCoordinate:initialLocation zoomLevel:14 maxZoomLevel:18 minZoomLevel:2 backgroundImage:nil];
    mapView.showsUserLocation = YES;
    mapView.zoom = 14;
    
    [mapView setConstraintsSouthWest:[mapView.tileSource latitudeLongitudeBoundingBox].southWest
                                northEast:[mapView.tileSource latitudeLongitudeBoundingBox].northEast];
    RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:mapView
                                                                    coordinate:mapView.centerCoordinate
                                                                      andTitle:@"Car Park"];
    
    [mapView addAnnotation:annotation];

    [self.view addSubview:mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
