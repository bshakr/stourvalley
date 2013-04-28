//
//  SVAEventDetailViewController.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 28/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "imageCollectionView.h"
@class EventDataModel;

@interface SVAEventDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSString *titleLabel;
@property (nonatomic, retain) NSString *descLabel;
@property (nonatomic, retain) NSString *dateLabel;
@property (nonatomic, retain) NSString *imageTag;
@property (nonatomic) NSInteger cellCount;



@property (strong, nonatomic) IBOutlet UITableView *eventTableView;
@property (nonatomic, strong) imageCollectionView *collectionView;


@end
