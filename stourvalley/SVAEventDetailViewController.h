//
//  SVAEventDetailViewController.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 28/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "imageCollectionView.h"
@class EventDataModel;
@class SVAWebView;
//@class ArtInstallationDataModel;

@class SVMapboxViewController;
//@class PopupViewController;

@interface SVAEventDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSString *titleLabel;
@property (nonatomic, retain) NSString *descLabel;
@property (nonatomic, retain) NSString *dateLabel;
@property (nonatomic, retain) NSString *imageTag;
@property (nonatomic, retain) NSString *bookingLink;
@property (nonatomic) NSInteger cellCount;

//- (ArtInstallationDataModel *) shareInstallation;


@property (strong, nonatomic) IBOutlet UITableView *eventTableView;
@property (nonatomic, strong) imageCollectionView *collectionView;
@property (strong, nonatomic) SVAWebView *webView;
//@property (strong, nonatomic) PopupViewController *popUpView;
@property (strong, nonatomic) SVMapboxViewController *mapView;


@end
