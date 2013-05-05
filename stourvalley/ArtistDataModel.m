//
//  ArtistDataModel.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 25/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "ArtistDataModel.h"
#import "Artist.h"

@interface ArtistDataModel()
{
    Artist *artist ;
}

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
- (NSString *)documentsDirectory;

- (NSArray *) artistArray;
- (NSArray *) arrayForKey;
- (NSArray *) arrayForObject;

@end

@implementation ArtistDataModel

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainContext = _mainContext;


//share accessor

+(id)sharedDataModel{
    static ArtistDataModel *__instance = nil;
    if(__instance == nil){
        __instance = [[ArtistDataModel alloc] init];
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

- (NSArray *)loadAllArtists
{
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Artist" inManagedObjectContext:_mainContext];
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
    _allArtits = [[NSMutableArray alloc] initWithArray:results];
    
    NSLog(@"ArtistDataModel.allEvents : %d", _allArtits.count);
    
    return [self allArtits];

}

-(void)creatArtists
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init]; //date format - MONTH DD, YYYY
    [df setDateStyle:NSDateFormatterLongStyle];
    
    NSArray *array = [NSArray arrayWithArray:[self artistArray]];
    //@"name", @"commissionDate", @"info",@"imageCount", nil];
    for (NSDictionary *obj in array) {
        NSString *name = [obj objectForKey:@"name"];
        NSString *comdate = [obj objectForKey:@"commissionDate"];
        NSString *info = [obj objectForKey:@"info"];
        NSString *count = [obj objectForKey:@"imageCount"];
        
        // NSLog(@"This is installation %@ by %@ at %@, %@  - %@ : %@", name, artist, lat, lon, createDate, info);
        artist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:_mainContext];
        
        [artist setName:name];
        [artist setCommissionDate:comdate];
        [artist setInfo:info];
        [artist setImageCount:[NSNumber numberWithInt:[count intValue]]];
       
        [_mainContext save:nil];
        
    }
    NSLog(@"Created model for Artists");
    
    
}

- (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_
{
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:moc_];
}


#pragma mark - DataSource methods

- (NSArray *)arrayForKey
{
    return [NSArray arrayWithObjects:@"name", @"commissionDate", @"info",@"imageCount", nil];
}

- (NSArray *) artistArray
{
    
    NSMutableArray *artists = [[NSMutableArray alloc] init] ;
    
    NSArray *key = [NSArray arrayWithArray:[self arrayForKey]];
    NSArray *arrayObj = [NSArray arrayWithArray:[self arrayForObject]];
    
    for (int i = 0; i < [[self arrayForObject] count]; i++) {
        NSArray *obj = [NSArray arrayWithArray:[arrayObj objectAtIndex:i]];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:obj forKeys:key];
        [artists addObject:dict];
    }
    
    
    return artists;
}


- (NSArray *) arrayForObject
{
    NSArray *artist0 = [NSArray arrayWithObjects:@"Mike Marshall", @"4 November - 17 December 2011", @"The third major exhibition resulting from Mike Marshall’s 2010-11 residency in King’s Wood and the New Forest took place at SVA Gallery and at Herbert Read Gallery, UCA Canterbury. Co-commissioned by SVA and ArtSway.",@"4", nil];
    
    NSArray *artist1 = [NSArray arrayWithObjects:@"Lee Patterson", @"2010 - 2012", @"Taking over the former home of Ashford School of Art, Elemental Fields comprised 4 distinct sound environments created from field recordings made through the seasons in King’s Wood and in the flood plain of Ashford.",@"5", nil];
    
    NSArray *artist2 = [NSArray arrayWithObjects:@"London Fieldworks", @"2008 - 2011", @"Perfomed a development of new animal habitats within King’s Wood. These luxury homes are modelled on the imperious palaces of Stalin, Ceauscescu and Mussolini and offer nesting and over-winter sites to native and migrant species",@"4", nil];
    
    NSArray *artist3 = [NSArray arrayWithObjects:@"Bethan Huws", @"2009", @"A Marriage in the King’s Forest was screened deep within King’s Wood on Saturday 26th and Sunday 27th September, 2009.",@"4", nil];
    
    NSArray *artist4 = [NSArray arrayWithObjects:@"Edward Chell", @"2009", @"Performed Carboretum - a temporary intervention, in association with StourValleyArts, located in the main King’s Wood car park, playfully confuses methods for the classification of tree species with techniques for demarcating car parking spaces",@"3", nil];
    
    NSArray *artist5 = [NSArray arrayWithObjects:@"Methew King", @"2007", @"King’s Wood Symphony was written by Matthew King.Electronic Score by Nye Parry.With further contributions from Mike Roberts and students from Guildhall School of Music & Drama plus students from local schools.",@"5", nil];
   
    NSArray *artist6 = [NSArray arrayWithObjects:@"Christopher Jones", @"2007", @"Forest Stars, 2007, taking 2000 lights illuminated the forest floor within King’s Wood creating a magical carpet of red that only became visible as dusk fell.",@"5", nil];
    
    NSArray *artist7 = [NSArray arrayWithObjects:@"Jem Finer", @"2006 - 2011", @"Jem Finer the first recipient of the prestigious PRS New Music Award has realised his proposal Score for a Hole in the Ground at King’s Wood. It is a post-digital work that relies purely on gravity and water to generate music.",@"4", nil];
    
    NSArray *artist8 = [NSArray arrayWithObjects:@"Jacques Nimki", @"2005 - 2006", @"Jacques Nimki worked in King’s Wood researching plant life on the floor of the forest. The results of this research informed an installation for Fabrica in Brighton, in the summer of 2006, with whom we collaborated on this project.",@"1", nil];
    
    NSArray *artist9 = [NSArray arrayWithObjects:@"Peter Fillingham", @"2004 - 2005", @"Peter Fillingham has designed a railing to lead you through the forest, but it doesn’t lead anywhere in particular and is at times quite hard to follow. As a fence it keeps nothing in or out but disappears into the trees its end unseen.",@"2", nil];
    
    NSArray *artist10 = [NSArray arrayWithObjects:@"Emily Richardson", @"2003 - 2004", @"Aspect is a response to the night and early morning light in King’s Wood through the seasons. A year of the forest condensed into nine minutes of 16mm films.",@"3", nil];
    
    NSArray *artist11 = [NSArray arrayWithObjects:@"Edwina FitzPatrick", @"2002 - 2004", @"During her residency in 2002-3, Edwina fitzPatrick used the forest as her arboreal laboratory. She created a range of King’s Wood perfumes with perfumers from Quest International plc, Ashford.",@"4", nil];
    
    NSArray *artist12 = [NSArray arrayWithObjects:@"Rosie Leventon", @"2003", @"Rosie Leventon has cleared sweet chestnut trees to carve out a space in the forest which is twice that of a B52 bomber.",@"5", nil];
    
    NSArray *artist13 = [NSArray arrayWithObjects:@"Lukasz Skapski", @"2003", @"Rosie Leventon has cleared sweet chestnut trees to carve out a space in the forest which is twice that of a B52 bomber.",@"5", nil];
    
    NSArray *artist14 = [NSArray arrayWithObjects:@"Richard Harris", @"2000", @"Polish artist Lukasz Skapski’s Via Lucem Continens (Avenue Containing Light) is a 140-metre avenue of 200 yew trees planted by local people.",@"5", nil];
    
    NSArray *all = [NSArray arrayWithObjects:artist0, artist1, artist2, artist3, artist4, artist5, artist6, artist7,
                    artist8, artist9, artist10, artist11, artist12, artist13, artist14, nil];
    
    return [NSArray arrayWithArray:all] ;

}



@end
