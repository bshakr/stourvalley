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
#import "ArtistDataModel.h"
#import "SVMapAnnotation.h"
#import "UIColor+RGB.h"

@interface SVMapboxViewController ()
{
    NSManagedObjectContext *context;
    NSArray *allInstallations;
    RMMapView *mapView;
    CLLocationCoordinate2D initialLocation;
    
}
-(ArtInstallationDataModel *) shareInstallation;
-(ArtistDataModel *) shareArtist;

@end

@implementation SVMapboxViewController


-(id) initWithLatitude:(NSNumber*)latitude andLongitude:(NSNumber*)longitude
{
    self = [self init];
    if (self)
    {
        initialLocation = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    }
    return self;
}
-(id) init
{
    self = [super init];
    if(self)
    {
        initialLocation = CLLocationCoordinate2DMake(51.2133, 0.8963);
    }

    return self;
}
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
    UIImage *navBG = [UIImage imageNamed:@"navbar.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBG forBarMetrics:UIBarMetricsDefault];

    
    
    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
    [self initalizeMapView];
}

- (void) initalizeMapView
{
    RMMBTilesSource *offlineSource = [[RMMBTilesSource alloc] initWithTileSetResource:@"stourvalley3" ofType:@"mbtiles"];
    
    mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:offlineSource
                                         centerCoordinate:initialLocation zoomLevel:14 maxZoomLevel:18 minZoomLevel:14 backgroundImage:nil];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapView.adjustTilesForRetinaDisplay = YES;
    mapView.showsUserLocation = YES;
    [self loadData];
    [self loadAnnotations];

}
-(void) loadData{
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
        NSLog(@"Load context failed");
    }

}
-(ArtInstallationDataModel *) shareInstallation
{
    return [ArtInstallationDataModel sharedDataModel];
}

-(void) loadAnnotations
{
    NSUInteger count = 0;
    for(id installation in allInstallations)
    {
        NSLog(@"The art installation latitude is : %@", [installation valueForKey:@"latitude"]);
        double latitude = [[installation valueForKey:@"latitude"] doubleValue];
        double longitude = [[installation valueForKey:@"longitude"] doubleValue];
        NSString *name = [installation valueForKey:@"name"];
        CLLocationCoordinate2D artCoordinate     = CLLocationCoordinate2DMake(latitude, longitude);
        NSString *imageName = [NSString stringWithFormat:@"install%d.png",count];
        SVMapAnnotation *artAnnotation = [[SVMapAnnotation alloc] initWithMapView:mapView
                                                                               coordinate:artCoordinate
                                                                                 andTitle:name
                                                                                andImageName:imageName];

        [mapView addAnnotation:artAnnotation];
        count++;

    }
    [self.view addSubview:mapView];

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
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[self listImage]
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(slideOut:)];
    [button setTintColor:[UIColor colorWithR:187 g:83 b:88 a:0.5]];
    return button;
}

#pragma mark - Event handlers



- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}

@end
