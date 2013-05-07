//
//  SVMapAnnotation.m
//  stourvalley
//
//  Created by Bassem on 07/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMapAnnotation.h"
#import <CoreGraphics/CoreGraphics.h>
#import "RMMarker.h"
#import "UIImage+Shadow.h"

@implementation SVMapAnnotation
- (id)initWithMapView:(RMMapView *)aMapView coordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle andImageName:(NSString *)imageName
{
    self = [super initWithMapView:aMapView coordinate:aCoordinate andTitle:aTitle];
    if(self)
    {
        self.markerImageName = imageName;
    }
    return self;
}
- (void)setLayer:(RMMapLayer *)newLayer
{
    if ( ! newLayer)
        [super setLayer:nil];
}

- (RMMapLayer *)layer
{
    if ( ! [super layer])
    {
        UIImage *markerImage = [UIImage imageNamed:self.markerImageName];
        UIImage *shadowMarkerImage = [markerImage imageWithShadow];
        RMMarker *marker = [[RMMarker alloc] initWithUIImage:shadowMarkerImage];
        
        marker.canShowCallout = YES;
        
        super.layer = marker;
    }
    
    return [super layer];
}

@end
