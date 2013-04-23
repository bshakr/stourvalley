//
//  Event.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 22/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * imageTag;
@property (nonatomic, retain) NSNumber * imageCount;

@end
