//
//  ArtInstallationDataModel.h
//  SVACoreData
//
//  Created by Treechot Shompoonut on 23/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArtInstallation;

@interface ArtInstallationDataModel : NSObject

+ (id)sharedDataModel;
- (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;

- (NSArray *)loadAllArtInstallations;
- (void)createArtInstallations;

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSMutableArray *allArtInstallations;

- (NSString *)modelName;
- (NSString *)pathToModel;
- (NSString *)storeFilename;
- (NSString *)pathToLocalStore;


@end
