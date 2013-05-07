//
//  SVMapAnnotation.m
//  stourvalley
//
//  Created by Bassem on 07/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMapAnnotation.h"

#import "RMMarker.h"

@implementation SVMapAnnotation
- (void)setLayer:(RMMapLayer *)newLayer
{
    if ( ! newLayer)
        [super setLayer:nil];
}

- (RMMapLayer *)layer
{
    if ( ! [super layer])
    {
        UIImage *markerImage = [UIImage imageNamed:@"map-marker.png"];
        RMMarker *marker = [[RMMarker alloc] initWithUIImage:markerImage];
        
        marker.canShowCallout = YES;
        
        super.layer = marker;
    }
    
    return [super layer];
}


@end
