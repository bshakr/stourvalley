//
//  ArtInstallation.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 23/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArtInstallation : NSManagedObject

@property (nonatomic, retain) NSString * creationDate;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * artist;

@end
