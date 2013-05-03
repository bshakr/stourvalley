//
//  EventDataModel.m
//  SVAExhibision
//
//  Created by Treechot Shompoonut on 21/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "EventDataModel.h"
#import "Event.h"



@interface EventDataModel()
{
    Event *event;
    Event *exhibition;
    

}

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
- (NSString *)documentsDirectory;
- (NSArray *)eventArray;
- (NSArray *) arrayForKey;
- (NSArray *) arrayForObject;

@end

@implementation EventDataModel

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainContext = _mainContext;



//share accessor

+(id)sharedDataModel{
    static EventDataModel *__instance = nil;
    if(__instance == nil){
        __instance = [[EventDataModel alloc] init];
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

- (NSArray *)getAllEvents
{
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:_mainContext];
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
    _allEvents = [[NSMutableArray alloc] initWithArray:results];
    NSLog(@"EventDataModel.allEvents : %d", _allEvents.count);
    
       return [self allEvents];
}

-(void)creatEvents{
 
    NSDateFormatter *df = [[NSDateFormatter alloc] init]; //date format - MONTH DD, YYYY
    [df setDateStyle:NSDateFormatterLongStyle];

    NSArray *array = [NSArray arrayWithArray:[self eventArray]];
  
    for (NSDictionary *obj in array) {
        NSString *name = [obj objectForKey:@"eventName"];
       // NSDate *stdate = [df dateFromString:[obj objectForKey:@"startDate"]];
       // NSDate *endate = [df dateFromString:[obj objectForKey:@"endDate"]];
        NSString *stdate = [obj objectForKey:@"startDate"];
        NSString *endate = [obj objectForKey:@"endDate"];
        NSString *detail = [obj objectForKey:@"detail"];
        NSString *tag = [obj objectForKey:@"imageTag"];
        NSString *count = [obj objectForKey:@"imageCount"];
        
        // NSLog(@"This is installation %@ by %@ at %@, %@  - %@ : %@", name, artist, lat, lon, createDate, info);
        event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:_mainContext];
        
        [event setEventName:name];
        [event setStartDate:stdate];
        [event setEndDate:endate];
        [event setDetail:detail];
        [event setImageTag:tag];
        [event setImageCount:[NSNumber numberWithInt:[count intValue]]];
        
        [_mainContext save:nil];

    }
    NSLog(@"Created");
    
    
}

- (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_
{
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}


#pragma mark - DataSource methods

- (NSArray *) arrayForKey
{
    return [NSArray arrayWithObjects:@"eventName", @"startDate", @"endDate",@"detail", @"imageTag",@"imageCount" , nil];
}

- (NSArray *)eventArray
{
    
    NSMutableArray *events = [[NSMutableArray alloc] init] ;
    
    NSArray *key = [NSArray arrayWithArray:[self arrayForKey]];
    NSArray *arrayObj = [NSArray arrayWithArray:[self arrayForObject]];
    
    for (int i = 0; i < [[self arrayForObject] count]; i++) {
        NSArray *obj = [NSArray arrayWithArray:[arrayObj objectAtIndex:i]];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:obj forKeys:key];
        [events addObject:dict];
    }
    
    
    return events;
}


- (NSArray *) arrayForObject
{
    NSArray *event1 = [NSArray arrayWithObjects:@"Make believe : Holy Story", @"April 27, 2013", @"June 01, 2013",@"Launch & forest walk - 11 - 2 Drinks & speeches 12.30 Forest Walk, led by the artist - 2.45. This exhibition brings together the woven objects and selected den photographs, revealing some of the artist’s and the children’s shared impulses to construct in the forest environment.", @"event1",@"5" , nil];
    
    NSArray *event2 = [NSArray arrayWithObjects:@"Science Nature & Identity", @"November 10, 2012", @"December 15, 2012",@"This new exhibition marks the end of the four-year Down Time  project during which SVA aimed to address physical and mental wellbeing through a series of training and artist-led activities working with 320 vulnerable young people and those at risk of disengagement.", @"event2",@"4" , nil];
    
    
    
    NSArray *all = [NSArray arrayWithObjects:event1, event2, nil];
    
    return [NSArray arrayWithArray:all] ;
}

//+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
//	NSParameterAssert(moc_);
//	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
//}

@end
