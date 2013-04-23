//
//  SVEventsViewController.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 22/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "imageCollectionView.h"
@class EventDataModel;

@interface SVEventsViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *detailArray;
@property (nonatomic, retain) NSMutableArray *stDateArray;
@property (nonatomic, retain) NSMutableArray *edDateArray;
@property (nonatomic, retain) NSMutableArray *imgNameArray;
@property (nonatomic, retain) NSMutableArray *inumArray;

-(EventDataModel *) shareEvent;

@property (strong, nonatomic) IBOutlet UITableView *eventTableView;
@property (nonatomic, strong) imageCollectionView *collectionView;



@end
