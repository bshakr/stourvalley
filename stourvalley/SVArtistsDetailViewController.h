//
//  SVArtistsDetailViewController.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 04/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "imageCollectionView.h"
@class ArtistDataModel;
//@class SVAWebView;
@class ArtInstallationDataModel;
@class SVMapboxViewController;

@interface SVArtistsDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSString *titleLabel;
@property (nonatomic, retain) NSString *descLabel;
@property (nonatomic, retain) NSString *dateLabel;
@property (nonatomic, retain) NSString *imageTag;

//@property (nonatomic, retain) NSString *bookingLink;
@property (nonatomic) NSInteger cellCount;

- (ArtInstallationDataModel *) shareInstallation;
- (void) getInstallationforArtist;

@property (strong, nonatomic) IBOutlet UITableView *artistTableView;
@property (nonatomic, strong) imageCollectionView *collectionView;
//@property (strong, nonatomic) SVAWebView *webView;
@property (strong, nonatomic) SVMapboxViewController *mapView;

@end
