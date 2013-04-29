//
//  ArtistDataModel.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 25/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Artist;

@interface ArtistDataModel : NSObject

+ (id)sharedDataModel;


- (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NSArray *)loadAllArtists;
- (void)creatArtists;

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSMutableArray *allArtits;
//@property (nonatomic, retain) NSMutableArray *svaevents;

- (NSString *)modelName;
- (NSString *)pathToModel;
- (NSString *)storeFilename;
- (NSString *)pathToLocalStore;



@end
