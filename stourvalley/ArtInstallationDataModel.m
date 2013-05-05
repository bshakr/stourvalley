//
//  ArtInstallationDataModel.m
//  SVACoreData
//
//  Created by Treechot Shompoonut on 23/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "ArtInstallationDataModel.h"
#import "ArtInstallation.h"


@interface ArtInstallationDataModel()
{
   
    ArtInstallation *artInst;
   
    
}

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
- (NSString *)documentsDirectory;

- (NSArray *) arrayForKey;
- (NSArray *) arrayForObject;
- (NSArray *)installationArray;

@end



@implementation ArtInstallationDataModel


@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainContext = _mainContext;



//share accessor
+(id)sharedDataModel{
    static ArtInstallationDataModel *__instance = nil;
    if(__instance == nil){
        __instance = [[ArtInstallationDataModel alloc] init];
    }
    
    return __instance;
}


- (NSString *)modelName {
    return @"Stourvalley";
}

- (NSString *)pathToModel {
    return [[NSBundle mainBundle] pathForResource:[self modelName]
                                           ofType:@"momd"];
}

- (NSString *)storeFilename {
    return [[self modelName] stringByAppendingPathExtension:@"sqlite"];
}

- (NSString *)pathToLocalStore {
    return [[self documentsDirectory] stringByAppendingPathComponent:[self storeFilename]];
}

- (NSString *)documentsDirectory {
    NSString *documentsDirectory = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSManagedObjectContext *)mainContext {
    if (_mainContext == nil) {
        _mainContext = [[NSManagedObjectContext alloc] init];
        _mainContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
    }
    
    return _mainContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSURL *storeURL = [NSURL fileURLWithPath:[self pathToModel]];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:storeURL];
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        NSLog(@"SQLITE STORE PATH: %@", [self pathToLocalStore]);
        NSURL *storeURL = [NSURL fileURLWithPath:[self pathToLocalStore]];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]
                                             initWithManagedObjectModel:[self managedObjectModel]];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSError *error = nil;
        
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:options
                                       error:&error]) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
            NSString *reason = @"Could not create persistent store.";
            NSException *exc = [NSException exceptionWithName:NSInternalInconsistencyException
                                                       reason:reason
                                                     userInfo:userInfo];
            @throw exc;
        }
        
        _persistentStoreCoordinator = psc;
    }
    
    return _persistentStoreCoordinator;
}


- (NSArray *)loadAllArtInstallations
{
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ArtInstallation" inManagedObjectContext:_mainContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *results = [[_mainContext executeFetchRequest:request error:&error] mutableCopy];
    if (!results) {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
        [NSException raise:@"Fetch data failed" format:@"Error : %@", [error localizedDescription]];
        NSLog(@"Error : %@", error);
    }
   
    _allArtInstallations = [[NSMutableArray alloc] initWithArray:results];
    
    
    return  _allArtInstallations;
}

-(void)createArtInstallations
{
    
    NSArray *array = [NSArray arrayWithArray:[self installationArray]];
    
    for (NSDictionary *obj in array) {
        NSString *name = [obj objectForKey:@"name"];
        NSString *artist = [obj objectForKey:@"artist"];
        NSString *lat = [obj objectForKey:@"latitude"];
        NSString *lon = [obj objectForKey:@"longitude"];
        NSString *createDate = [obj objectForKey:@"creationDate"];
        NSString *info = [obj objectForKey:@"info"];
        
       // NSLog(@"This is installation %@ by %@ at %@, %@  - %@ : %@", name, artist, lat, lon, createDate, info);
        artInst = [NSEntityDescription insertNewObjectForEntityForName:@"ArtInstallation" inManagedObjectContext:_mainContext];
        
        [artInst setName:name];
        [artInst setArtist:artist];
        [artInst setLatitude:[NSNumber numberWithFloat:[lat floatValue]]];
        [artInst setLongitude:[NSNumber numberWithFloat:[lon floatValue]]];
        [artInst setCreationDate:createDate];
        [artInst setInfo:info];
        
        [_mainContext save:nil];

        
    }
    NSLog(@"Created");
}

- (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_
{
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"ArtInstallation" inManagedObjectContext:moc_];
}


#pragma mark - DataSource methods

- (NSArray *) arrayForKey
{
    return [NSArray arrayWithObjects:@"name", @"artist", @"creationDate",@"latitude",
            @"longitude",@"info" , nil];
}

- (NSArray *)installationArray
{
    
    NSMutableArray *installations = [[NSMutableArray alloc] init] ;
    
    NSArray *key = [NSArray arrayWithArray:[self arrayForKey]];
    NSArray *arrayObj = [NSArray arrayWithArray:[self arrayForObject]];
   
    for (int i = 0; i < [[self arrayForObject] count]; i++) {
        NSArray *obj = [NSArray arrayWithArray:[arrayObj objectAtIndex:i]];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:obj forKeys:key];
        [installations addObject:dict];
    }
  
    
    return installations;
}


- (NSArray *) arrayForObject
{
    NSArray *obj2 = [NSArray arrayWithObjects:@"Untitled", @"Richard Harris", @"1994", @"51.216000", @"0.897000", @"Richard Harris searched hard to find the configuration of coppiced chestnuts that he wanted. He bent and tied their branches, using hedge-laying techniques to create a semicircular archway. The sculpture has slowly matured and Harris returns each winter to trim and tie the annual growth.",  nil];
    
    NSArray *obj4 = [NSArray arrayWithObjects:@"Ring", @"Rosie Leventon", @"2003", @"51.221500", @"0.909167", @"An earthwork inspired by the pre-historic barrows,or ancient burial mounds, which are found in King's Wood and nearby.The circular sides with earth on the side of a hill adjacent to one of the main rides. The deep centre was dug out with the aid of a JCB at 360 degrees.",  nil];
    
    NSArray *obj6 = [NSArray arrayWithObjects:@"Via Lucem Continens", @"Lukasz Skapski", @"2000", @"51.221001", @"0.914667", @"A 140-metre avenue of 200 yew trees planted by local people. The artwork is a device for viewing the setting sun: it framed the sunset on midsummer’s day 2000 and will act as a battery of energy over the next millennium-during which time the yew trees will slowly mature.",  nil];
    
    NSArray *obj8 = [NSArray arrayWithObjects:@"B52", @"Rosie Leventon", @"2003", @"51.214048",@"0.901866", @"The artist has cleared sweet chestnut trees to carve out a space in the forest which is twice that of a B52 bomber. She wanted to subvert this aircraft’s aggressive power into something positive. Abundant light now falls on the forest floor, bringing new life, regeneration and biodiversity. It can also be seen as future archaeology.",  nil];
    
    NSArray *obj9 = [NSArray arrayWithObjects:@"Hill Seat", @"Tim norris", @"1995", @"51.209572", @"0.920877", @"Tim Norris has made two seats, one dug into the chalk, the other nestled within a coppiced chestnut. Unusual and unexpected, they nevertheless integrate with the existing landscape and provide welcome rest on the long North Downs Way.",  nil];
    
    NSArray *obj10 = [NSArray arrayWithObjects:@"Coppice Seat", @"Tim norris", @"1994", @"51.219841",@"0.931606", @"Tim Norris has made two seats, one dug into the chalk, the other nestled within a coppiced chestnut. Unusual and unexpected, they nevertheless integrate with the existing landscape and provide welcome rest on the long North Downs Way.",  nil];
    
    NSArray *obj11 = [NSArray arrayWithObjects:@"The Last Eleven Years", @"Peter Fillingham", @"2004 - 2005", @"51.217999", @"0.903167", @"As a fence it keeps nothing in or out but disappears into the trees its end unseen.Made by a local fencer in softwood it sits lightly in its forest surroundings drawing a line through the forest and raising the question, Is it an artwork or is it a Forestry construction?",  nil];
    
    
    NSArray *obj12 = [NSArray arrayWithObjects:@"Score for a Hole in the Ground", @"Jem Finer", @"2006 - 2011", @"51.223000", @"0.909833", @"An award-winning piece inspired by suikinkutsu, water chimes found in temple gardens of Japan, Score for a Hole in the Ground uses tuned percussive instruments, played by falling water, to create music. Finer describes his piece as “both music and an integrated part of the landscape and the forces that operate on it and in it",  nil];
  
    NSArray *obj13 = [NSArray arrayWithObjects:@"Super Kingdom", @"London Fieldworks", @"2008", @"51.224834", @"0.908333", @"Super Kingdom is a development of new animal habitats within King’s Wood. These luxury homes are modelled on the imperious palaces of Stalin, Ceauscescu and Mussolini and offer nesting and over-winter sites to native and migrant species.",  nil];
    
    NSArray *obj14 = [NSArray arrayWithObjects:@"Miracle of the Legs", @"Gregory Pryor", @"2009", @"51.222079", @"0.911522", @"Modelled on the legs of forest walkers, 3 wooden limbs appear high in the canopy of beech trees. This unexpected grafting echoes the iconography associated with Sts. Cosmas and Damian, patron saints of Challock’s parish church.",  nil];
    
    //obj2, obj4, obj6, obj8, obj11, obj12, obj13 from site survey
    //obj9, obj10, obj14 from SVA-google map
    NSArray *all = [NSArray arrayWithObjects:obj2, obj4, obj6, obj8, obj9, obj10, obj11, obj12, obj13, obj14, nil];
   
    return [NSArray arrayWithArray:all] ;
}



@end
