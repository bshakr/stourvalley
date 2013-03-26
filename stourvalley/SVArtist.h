//
//  SVArtist.h
//  stourvalley
//
//  Created by Bassem on 25/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SVArtist : NSManagedObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *info;

@end
