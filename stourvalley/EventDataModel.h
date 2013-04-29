//
//  EventDataModel.h
//  SVAExhibision
//
//  Created by Treechot Shompoonut on 21/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Event;


@interface EventDataModel : NSObject

+ (id)sharedDataModel;

//+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NSArray *)getAllEvents;
- (void)creatEvents;

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSMutableArray *allEvents;
@property (nonatomic, retain) NSMutableArray *svaevents;

- (NSString *)modelName;
- (NSString *)pathToModel;
- (NSString *)storeFilename;
- (NSString *)pathToLocalStore;



@end
