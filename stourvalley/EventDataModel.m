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

    NSArray *name = [NSArray arrayWithArray:[self arrayForNames]];
    NSArray *st = [NSArray arrayWithArray:[self arrayForStartDates]];
    NSArray *ed = [NSArray arrayWithArray:[self arrayForEndDates]];
    NSArray *dt = [NSArray arrayWithArray:[self arrayForDetails]];
    NSArray *img = [NSArray arrayWithArray:[self arrayForImages]];
    NSArray *num = [NSArray arrayWithArray:[self arrayForCount]];
    
    
    for (int i=0; i<name.count; i++) {
        event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:_mainContext];
       // NSLog(@"Event %d is %@, %@", i, [name objectAtIndex:i], [st objectAtIndex:i]);
        [event setEventName:[name objectAtIndex:i]];
        NSDate *stdate = [df dateFromString:[st objectAtIndex:i]];
        [event setStartDate:stdate];
         NSDate *eddate = [df dateFromString:[ed objectAtIndex:i]];
        [event setEndDate:eddate];
        [event setDetail:[dt objectAtIndex:i]];
        [event setImageTag:[img objectAtIndex:i]];
        [event setImageCount:[num objectAtIndex:i]];
        
        [_mainContext save:nil];
    }
    
}

- (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_
{
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}




#pragma mark - DataSource methods

- (NSArray *)arrayForNames;
{
    return [NSArray arrayWithObjects:@"Make believe : Holy Story", @"Exhibition in May", @"Exhibition in June",@"Exhibition in July",
            @"Exhibition in August",nil];
}
- (NSArray *)arrayForStartDates;
{
    return [NSArray arrayWithObjects:@"April 27, 2013", @"May 01, 2013", @"June 01, 2013",@"July 01, 2013",
                          @"August 01, 2013",nil];
}
- (NSArray *)arrayForEndDates;
{
    return  [NSArray arrayWithObjects:@"June 01, 2013", @"May 01, 2013", @"June 01, 2013",@"July 01, 2013",
     @"August 01, 2013",nil];
}
- (NSArray *)arrayForDetails;
{
    return [NSArray arrayWithObjects:@"Launch & forest walk - 11 - 2 Drinks & speeches 12.30 Forest Walk, led by the artist - 2.45. This exhibition brings together the woven objects and selected den photographs, revealing some of the artist’s and the children’s shared impulses to construct in the forest environment.",
            @"This is event 2",
            @"This is event 3",
            @"This is event 4",
            @"This is event 5",nil];
}

- (NSArray *)arrayForImages
{
    return [NSArray arrayWithObjects:@"event1", @"event2", @"event3",@"event4",
            @"event5",nil];
}

- (NSArray *)arrayForCount
{
    ///number of images for event default = 0
    NSMutableArray *myNumbers = [NSMutableArray array];
    [myNumbers addObject:[NSNumber numberWithInt:5]];
    [myNumbers addObject:[NSNumber numberWithInt:3]];
    [myNumbers addObject:[NSNumber numberWithInt:3]];
    [myNumbers addObject:[NSNumber numberWithInt:4]];
    [myNumbers addObject:[NSNumber numberWithInt:5]];
    
    
    return myNumbers;
    
}

//+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
//	NSParameterAssert(moc_);
//	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
//}

@end
