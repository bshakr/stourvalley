//
//  SVArtistsViewController.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 04/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class ArtistDataModel;
@class SVArtistsDetailViewController;

@interface SVArtistsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *detailArray;
@property (nonatomic, retain) NSMutableArray *stDateArray;
@property (nonatomic, retain) NSMutableArray *inumArray;
@property (nonatomic, retain) NSString *dateLabel;

-(ArtistDataModel *) shareArtist;

@property (nonatomic, strong) SVArtistsDetailViewController *artistsDetailView;

- (void) loadData;

@end
