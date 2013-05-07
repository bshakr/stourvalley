//
//  SVMapAnnotation.h
//  stourvalley
//
//  Created by Bassem on 07/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "RMAnnotation.h"

@interface SVMapAnnotation : RMAnnotation
@property NSString *markerImageName;
- (id)initWithMapView:(RMMapView *)aMapView coordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle andImageName:(NSString *)imageName;

@end
