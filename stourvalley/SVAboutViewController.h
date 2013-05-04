//
//  SVAboutViewController.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 24/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AboutLayout;
@class SVAWebView;


@interface SVAboutViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>


//@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet AboutLayout *aboutPageLayout;
@property (strong, nonatomic) SVAWebView *webView;

@end
