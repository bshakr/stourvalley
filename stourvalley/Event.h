//
//  Event.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 22/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * endDate;
@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSString * startDate;
@property (nonatomic, retain) NSString * imageTag;
@property (nonatomic, retain) NSNumber * imageCount;
@property (nonatomic, retain) NSString * bookingLink;

@end
