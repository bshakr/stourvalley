//
//  Artist.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 25/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSNumber * imageCount;
@property (nonatomic, retain) NSString * commissionDate;

@end
