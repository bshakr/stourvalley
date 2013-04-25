//
//  SVAboutViewController.h
//  stourvalley
//
//  Created by Bassem on 12/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AboutLayout;


@interface SVAboutViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>


//@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet AboutLayout *aboutPageLayout;

@end
