//
//  SVMapboxViewController.m
//  stourvalley
//
//  Created by Bassem on 19/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMapboxViewController.h"
#import "Mapbox.h"
#import "NVSlideMenuController.h"
#import "ArtInstallationDataModel.h"

@interface SVMapboxViewController ()
{
    NSManagedObjectContext *context;
    NSArray *allInstallations;
    
}
-(ArtInstallationDataModel *) shareInstallation;

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
    
    //Fetch data from datamodel
    context = [[self shareInstallation ] mainContext];
    
    if(context){
        NSLog(@"Context is ready to use");
        allInstallations = [[self shareInstallation] loadAllArtInstallations];
        if (allInstallations.count == 0) {
            
            NSLog(@"No data, allInstallations is nil");
            [[self shareInstallation] createArtInstallations];
            NSLog(@"Inserted installations");
            allInstallations = [[self shareInstallation] loadAllArtInstallations];
            NSLog(@"allInstalltion = %d", allInstallations.count);
        }
        
    }else{
        NSLog(@"Context == nil");
    }
    
    
    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
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

-(ArtInstallationDataModel *) shareInstallation
{
    return [ArtInstallationDataModel sharedDataModel];
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

#pragma mark - Event handlers

- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}

@end
